import type { Plugin } from "@opencode-ai/plugin";

const STRIP_KEYS = new Set(["cache_control", "cacheControl", "promptCacheKey"]);

function scrub(value: any): void {
  if (!value || typeof value !== "object") return;
  if (Array.isArray(value)) {
    for (const item of value) scrub(item);
    return;
  }

  for (const key of Object.keys(value)) {
    if (STRIP_KEYS.has(key)) {
      console.error(`[strip-cache] Removing key: ${key}`);
      delete value[key];
      continue;
    }
    scrub(value[key]);
  }
}

export const StripCacheControl: Plugin = async () => {
  console.error("[strip-cache] Plugin loaded");
  return {
    async "chat.params"(input) {
      console.error(`[strip-cache] chat.params called for provider: ${input?.model?.providerID}`);
      // Strip cache_control from all input
      scrub(input);
    },
  };
};

export default StripCacheControl;
