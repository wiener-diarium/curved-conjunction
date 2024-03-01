import { collection, config, fields, type GitHubConfig, type LocalConfig } from "@keystatic/core";

const isProd = process.env.NODE_ENV === "production";
const localMode: LocalConfig["storage"] = {
	kind: "local",
};
const remoteMode: GitHubConfig["storage"] = {
	kind: "github",
	repo: "wiener-diarium/curved-conjunction",
};

export default config({
	storage: isProd ? remoteMode : localMode,
	collections: {
		posts: collection({
			label: "Posts",
			slugField: "title",
			path: "src/content/posts/*",
			entryLayout: "content",
			format: { contentField: "content" },
			schema: {
				title: fields.slug({ name: { label: "Title" } }),
				pubDate: fields.date({
					label: "Publication Date",
					defaultValue: "today",
					validation: { isRequired: true },
				}),
				description: fields.text({ label: "Description" }),
				author: fields.text({ label: "Author" }),
				content: fields.document({
					label: "Content",
					formatting: true,
					dividers: true,
					links: true,
					images: true,
				}),
			},
		}),
		pages: collection({
			label: "Pages",
			slugField: "title",
			path: "src/content/pages/*/",
			entryLayout: "content",
			format: { contentField: "content" },
			schema: {
				title: fields.slug({ name: { label: "Title" } }),
				content: fields.document({
					label: "Content",
					formatting: true,
					dividers: true,
					links: true,
					images: true,
				}),
			},
		}),
	},
});
