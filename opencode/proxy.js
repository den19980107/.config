#!/usr/bin/env node
// Simple proxy that strips cache_control from requests
// Usage: node proxy.js
// Then set baseURL to http://localhost:8765/v1

const http = require('http');
const https = require('https');

const TARGET = 'https://api.rdsec.trendmicro.com';
const PORT = 8765;

function stripCacheControl(obj) {
  if (!obj || typeof obj !== 'object') return;
  if (Array.isArray(obj)) {
    obj.forEach(stripCacheControl);
    return;
  }
  for (const key of Object.keys(obj)) {
    if (key === 'cache_control' || key === 'cacheControl' || key === 'promptCacheKey') {
      delete obj[key];
    } else {
      stripCacheControl(obj[key]);
    }
  }
}

const server = http.createServer((req, res) => {
  let body = '';
  req.on('data', chunk => body += chunk);
  req.on('end', () => {
    let payload = body;
    if (body) {
      try {
        const parsed = JSON.parse(body);
        stripCacheControl(parsed);
        payload = JSON.stringify(parsed);
      } catch (e) {}
    }

    const options = {
      hostname: 'api.rdsec.trendmicro.com',
      port: 443,
      path: '/prod/aiendpoint' + req.url,
      method: req.method,
      headers: {
        ...req.headers,
        host: 'api.rdsec.trendmicro.com',
        'content-length': Buffer.byteLength(payload),
      },
    };

    const proxyReq = https.request(options, proxyRes => {
      res.writeHead(proxyRes.statusCode, proxyRes.headers);
      proxyRes.pipe(res);
    });

    proxyReq.on('error', err => {
      console.error('Proxy error:', err);
      res.writeHead(502);
      res.end('Proxy error');
    });

    proxyReq.write(payload);
    proxyReq.end();
  });
});

server.listen(PORT, () => {
  console.log(`Proxy running on http://localhost:${PORT}`);
  console.log('Use baseURL: http://localhost:8765/v1');
});
