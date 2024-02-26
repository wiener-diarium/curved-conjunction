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
