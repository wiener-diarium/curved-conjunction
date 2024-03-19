import { collection, config, fields, type GitHubConfig, type LocalConfig } from "@keystatic/core";
import { wrapper } from "@keystatic/core/content-components";

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
				// content: fields.document({
				// 	label: "Content",
				// 	formatting: true,
				// 	dividers: true,
				// 	links: true,
				// 	images: {
				// 		directory: "/src/assets",
				// 		publicPath: "/src/assets",
				// 		schema: {
				// 			title: fields.text({
				// 				label: "Title",
				// 				description: "The text to display under the image in a caption.",
				// 			}),
				// 		},
				// 	},
				// 	componentBlocks: {
				// 		"text-image": component({
				// 			label: "Container with text and image",
				// 			schema: {
				// 				textContainer: fields.text({
				// 					label: "Insert Text",
				// 					description: "Text to show nex to the image",
				// 					validation: {
				// 						length: {
				// 							min: 20,
				// 						},
				// 					},
				// 				}),
				// 				image: fields.image({
				// 					label: "Title Image",
				// 					directory: "/src/assets",
				// 					publicPath: "/src/assets",
				// 				}),
				// 				image_alt: fields.text({
				// 					label: "Image Alt",
				// 					description: "The alt text for the image",
				// 				}),
				// 			},
				// 			preview: () => null,
				// 		}),
				// 	},
				// }),
				content: fields.mdx({
					label: "Content",
					formatting: true,
					dividers: true,
					links: true,
					images: {
						directory: "/src/assets",
						publicPath: "/src/assets",
						schema: {
							title: fields.text({
								label: "Title",
								description: "The text to display under the image in a caption.",
							}),
						},
					},
					components: {
						TextImage: wrapper({
							label: "Text and Image",
							description: "A container with text and an image",
							schema: {
								text: fields.text({
									label: "Text",
									description: "The text to display next to the image.",
									validation: {
										length: {
											min: 20,
										},
									},
								}),
								image: fields.image({
									label: "Image",
									directory: "/src/assets",
									publicPath: "/src/assets",
								}),
								image_alt: fields.text({
									label: "Image Alt",
									description: "The alt text for the image",
								}),
							},
						}),
					},
				}),
				image: fields.image({
					label: "Image",
					directory: "/src/assets",
					publicPath: "/src/assets",
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
					images: {
						directory: "public",
						publicPath: "public",
						schema: {
							title: fields.text({
								label: "Title",
								description: "The text to display under the image in a caption.",
							}),
						},
					},
				}),
				image: fields.image({
					label: "Image",
					directory: "/src/assets",
					publicPath: "/src/assets",
				}),
			},
		}),
	},
});
