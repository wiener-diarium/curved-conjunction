import markdoc from "@astrojs/markdoc";
import react from "@astrojs/react";
import tailwind from "@astrojs/tailwind";
import { defineConfig } from "astro/config";
import icon from "astro-icon";

const prodUrl = "https://wiener-diarium.github.io";
// const devUrl = "https://curved-conjunction.vercel.app";
const prodBase = "/curved-conjunction";
// const devBase = "/";

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
		react(),
		tailwind(),
	],
	output: "static",
	server: {
		port: 3000,
	},
	site: prodUrl,
	base: prodBase,
});
