import markdoc from "@astrojs/markdoc";
import react from "@astrojs/react";
import vercel from "@astrojs/vercel/serverless";
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
	site: "https://wiener-diarium.github.io",
	base: "/curved-conjunction",
	adapter: vercel(),
});
