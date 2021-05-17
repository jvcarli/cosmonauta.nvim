-- shfmt formatter
-- https://github.com/koalaman/shellcheck
--
-- on macOS install it with:
-- brew install shfmt

return {
    formatCommand = 'shfmt -ci -s -bn',
    formatStdin = true
}
