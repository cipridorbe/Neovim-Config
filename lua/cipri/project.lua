local project_ok, project = pcall(require, "project_nvim")
if not project_ok then
	return
end

project.setup()

local telescope_ok, telescope = pcall(require, "telescope")
if telescope_ok then
	telescope.load_extension('projects')
end
