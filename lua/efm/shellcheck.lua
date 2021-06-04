-- shellcheck linter
-- config bellow not working, why?
-- return {
--     lintCommand = "shellcheck -f gcc -x -",
--     lintStdin = true,
--     lintFormats = {"%f=%l:%c: %trror: %m", "%f=%l:%c: %tarning: %m", "%f=%l:%c: %tote: %m"},
--     lintSource = "shellcheck"
-- }

-- working
return {
    LintCommand = 'shellcheck -f gcc -x',
    lintFormats = {'%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m'}
}
