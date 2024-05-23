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
		publications: collection({
			label: "Publikationen",
			slugField: "title",
			path: "src/content/publications/*",
			format: { data: "json" },
			schema: {
				title: fields.slug({
					name: { label: "Titel" },
				}),
				publicationUnstructured: fields.text({
					label: "Publikation unstrukturiert",
					multiline: true,
				}),
				authors: fields.array(
					fields.object({
						firstName: fields.text({ label: "Vorname" }),
						lastName: fields.text({ label: "Nachname" }),
						middleName: fields.text({ label: "Zweiter Vorname" }),
					}),
					{
						label: "Autor(en)",
					},
				),

				year: fields.text({
					label: "Jahr",
				}),
				publishedIn: fields.text({
					label: "Publiziert in",
				}),
				publishers: fields.text({
					label: "Verlag",
				}),
				pubPlace: fields.text({
					label: "Erscheinungsort",
				}),
				volume: fields.text({
					label: "Band",
				}),
				pages: fields.text({
					label: "Seiten",
				}),
				url: fields.text({
					label: "URL",
				}),
				urldate: fields.date({
					label: "Zugriffsdatum",
				}),
			},
		}),
		presentations: collection({
			label: "Präsentationen",
			slugField: "title",
			path: "src/content/presentations/*",
			format: { data: "json" },
			schema: {
				title: fields.slug({
					name: { label: "Titel" },
				}),
				presentationUnstructured: fields.text({
					label: "Präsentationen unstrukturiert",
					multiline: true,
				}),
				type: fields.select({
					label: "Typ",
					options: [
						{ label: "Workshop", value: "Workshop" },
						{ label: "Vortrag", value: "Vortrag" },
						{ label: "Poster", value: "Poster" },
					],
					defaultValue: "Vortrag",
				}),
				authors: fields.array(
					fields.object({
						firstName: fields.text({ label: "Vorname" }),
						lastName: fields.text({ label: "Nachname" }),
						middleName: fields.text({ label: "Zweiter Vorname" }),
					}),
					{
						label: "Autor(en)",
					},
				),
				date: fields.date({
					label: "Datum",
				}),
				place: fields.text({
					label: "Ort",
				}),
				url: fields.text({
					label: "URL",
				}),
			},
		}),
		events: collection({
			label: "Events",
			slugField: "title",
			path: "src/content/events/*",
			entryLayout: "content",
			format: {
				contentField: "content",
			},
			schema: {
				type: fields.select({
					label: "Typ",
					options: [
						{ label: "Workshop", value: "Workshop" },
						{ label: "Vortrag", value: "Vortrag" },
						{ label: "Konferenz", value: "Konferenz" },
						{ label: "Buchpräsentation", value: "Buchpräsentation" },
					],
					defaultValue: "Vortrag",
				}),
				authors: fields.array(
					fields.object({
						firstName: fields.text({ label: "Vorname" }),
						lastName: fields.text({ label: "Nachname" }),
						middleName: fields.text({ label: "Zweiter Vorname" }),
					}),
					{
						label: "Autor(en)",
					},
				),
				title: fields.slug({
					name: { label: "Titel" },
				}),
				date: fields.date({
					label: "Datum",
				}),
				place: fields.text({
					label: "Ort",
				}),
				url: fields.text({
					label: "URL",
				}),
				image: fields.image({
					label: "Titelbild",
					directory: "public/images/events/title",
					publicPath: "/images/events/title",
				}),
				content: fields.mdx({
					label: "Content",
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
									directory: "public/images/events/component",
									publicPath: "/images/events/component",
								}),
								image_alt: fields.text({
									label: "Image Alt",
									description: "The alt text for the image",
								}),
							},
						}),
						Gallery: wrapper({
							label: "Gallerie",
							description: "Eine Gallerie mit Bildern",
							schema: {
								images: fields.object(
									{
										image: fields.image({
											label: "Bild",
											directory: "public/images/events/component",
											publicPath: "/images/events/component",
										}),
										alt: fields.text({
											label: "Alt",
										}),
										caption: fields.text({
											label: "Caption",
										}),
									},
									{
										label: "Bilder",
									},
								),
							},
						}),
						SingleImage: wrapper({
							label: "Einzelbild",
							description: "Ein einzelnes Bild",
							schema: {
								image: fields.object(
									{
										image: fields.image({
											label: "Bild",
											directory: "public/images/news/component",
											publicPath: "/images/news/component",
										}),
										alt: fields.text({
											label: "Alt",
										}),
										caption: fields.text({
											label: "Caption",
										}),
									},
									{
										label: "Einzelbild",
									},
								),
							},
						}),
					},
				}),
			},
		}),
		news: collection({
			label: "Neuigkeiten",
			slugField: "title",
			path: "src/content/news/*",
			entryLayout: "content",
			format: {
				contentField: "content",
			},
			schema: {
				authors: fields.array(
					fields.object({
						firstName: fields.text({ label: "Vorname" }),
						lastName: fields.text({ label: "Nachname" }),
						middleName: fields.text({ label: "Zweiter Vorname" }),
					}),
					{
						label: "Autor(en)",
					},
				),
				title: fields.slug({
					name: { label: "Titel" },
				}),
				date: fields.date({
					label: "Datum",
				}),
				url: fields.text({
					label: "URL",
				}),
				image: fields.image({
					label: "Titelbild",
					directory: "public/images/news/title",
					publicPath: "/images/news/title",
				}),
				content: fields.mdx({
					label: "Content",
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
									directory: "public/images/news/component",
									publicPath: "/images/news/component",
								}),
								image_alt: fields.text({
									label: "Image Alt",
									description: "The alt text for the image",
								}),
							},
						}),
						Gallery: wrapper({
							label: "Gallerie",
							description: "Eine Gallerie mit Bildern",
							schema: {
								images: fields.array(
									fields.object(
										{
											image: fields.image({
												label: "Bild",
												directory: "public/images/news/component",
												publicPath: "/images/news/component",
											}),
											alt: fields.text({
												label: "Alt",
											}),
											caption: fields.text({
												label: "Caption",
											}),
										},
										{
											label: "Bilder",
										},
									),
								),
							},
						}),
						SingleImage: wrapper({
							label: "Einzelbild",
							description: "Ein einzelnes Bild",
							schema: {
								image: fields.object(
									{
										image: fields.image({
											label: "Bild",
											directory: "public/images/news/component",
											publicPath: "/images/news/component",
										}),
										alt: fields.text({
											label: "Alt",
										}),
										caption: fields.text({
											label: "Caption",
										}),
									},
									{
										label: "Einzelbild",
									},
								),
							},
						}),
					},
				}),
			},
		}),
	},
});
