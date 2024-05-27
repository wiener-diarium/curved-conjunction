/** @type {import('tailwindcss').Config} */
/** --no-ignore */
module.exports = {
	content: [
		"./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}",
		"./edition/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}",
	],
	theme: {
		extend: {
			container: {
				screens: {
					xs: "320px",
					sm: "540px",
					md: "728px",
					lg: "984px",
					xl: "1240px",
					"2xl": "1496px",
				},
			},
		},
		screens: {
			sm: { min: "320px", max: "767px" },
			// => @media (min-width: 640px and max-width: 767px) { ... }

			md: { min: "768px", max: "1023px" },
			// => @media (min-width: 768px and max-width: 1023px) { ... }

			lg: { min: "1024px", max: "1279px" },
			// => @media (min-width: 1024px and max-width: 1279px) { ... }

			xl: { min: "1280px", max: "1535px" },
			// => @media (min-width: 1280px and max-width: 1535px) { ... }

			"2xl": { min: "1536px" },
			// => @media (min-width: 1536px) { ... }
		},
	},
	plugins: [],
};
