// Import utilities from `astro:content`
import { defineCollection, z } from "astro:content";
// Define a `type` and `schema` for each collection
const postsCollection = defineCollection({
	type: "content",
	schema: z.object({
		title: z.string(),
		pubDate: z.string(),
		description: z.string(),
		author: z.string(),
		image: z.string().optional(),
	}),
});
const pagesCollection = defineCollection({
	type: "content",
	schema: z.object({
		title: z.string(),
		image: z.string().optional(),
	}),
});

// Export a single `collections` object to register your collection(s)
export const collections = {
	posts: postsCollection,
	pages: pagesCollection,
};
