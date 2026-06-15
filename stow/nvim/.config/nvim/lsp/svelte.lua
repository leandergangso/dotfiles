return {
	cmd = { "svelteserver", "--stdio" },
	filetypes = { "svelte" },
	root_markers = {
		"svelte.config.js",
		"svelte.config.cjs",
		"svelte.config.mjs",
		"svelte.config.ts",
		"package.json",
		".git",
	},
}
