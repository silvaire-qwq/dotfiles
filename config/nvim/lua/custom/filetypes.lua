vim.filetype.add({
	pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
	extension = {
		qmt = "qmt",
		ipynb = "ipynb",
		ent = "xml",
	},
	filename = {
		["Snakefile"] = "snakemake",
	},
})
