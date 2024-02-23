import markdoc from "@astrojs/markdoc";
import node from "@astrojs/node";
import react from "@astrojs/react";
import keystatic from "@keystatic/astro";
import { defineConfig } from "astro/config";
import icon from "astro-icon";

// https://astro.build/config
export default defineConfig({
	integrations: [
		icon({
			include: {
				lucide: ["*"],
			},
			svgoOptions: {
				multipass: true,
				plugins: [
					{
						name: "preset-default",
						params: {
							overrides: {
								removeViewBox: false,
							},
						},
					},
				],
			},
		}),
		markdoc(),
		keystatic(),
		react(),
	],
	output: "hybrid",
	server: {
		port: 3000,
	},
	site: process.env.PUBLIC_APP_BASE_URL,
	base: `/${process.env.PUBLIC_KEYSTATIC_GITHUB_APP_SLUG}`,
	adapter: node({
		mode: "standalone",
	}),
});
