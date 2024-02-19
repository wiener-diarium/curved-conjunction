import { defineConfig } from "astro/config";
import icon from "astro-icon";
import markdoc from "@astrojs/markdoc";
import keystatic from '@keystatic/astro';

import vercel from "@astrojs/vercel/serverless";

// https://astro.build/config
export default defineConfig({
  integrations: [icon({
    include: {
      lucide: ["*"]
    },
    svgoOptions: {
      multipass: true,
      plugins: [{
        name: "preset-default",
        params: {
          overrides: {
            removeViewBox: false
          }
        }
      }]
    }
  }), markdoc(), keystatic()],
  output: 'hybrid',
  server: {
    port: 3000
  },
  site: process.env.PUBLIC_APP_BASE_URL,
  adapter: vercel()
});