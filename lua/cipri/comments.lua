local comment_ok, comment = pcall(require, "Comment")
if not comment_ok then
	vim.notify("Could not load Comment plugins")
	return
end

comment.setup()
