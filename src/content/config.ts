// Import utilities from `astro:content`
import { defineCollection, z } from "astro:content";

// Export a single `collections` object to register your collection(s)
export const collections = {
	posts: defineCollection({
		type: "content",
		schema: ({ image }) =>
			z.object({
				title: z.string(),
				pubDate: z.date(),
				description: z.string(),
				author: z.string(),
				image: image().optional(),
			}),
	}),
	pages: defineCollection({
		type: "content",
		schema: ({ image }) =>
			z.object({
				title: z.string(),
				image: image().optional(),
			}),
	}),
};
