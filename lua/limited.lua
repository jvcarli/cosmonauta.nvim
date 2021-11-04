-- limit lsp diagnostics to show a specific severity in signs column
-- TODO: fix function signature for new diagnostics handlers
-- see: https://www.reddit.com/r/neovim/comments/mvhfw7/can_built_in_lsp_diagnostics_be_limited_to_show_a/gvd8rb9/?utm_source=share&utm_medium=web2x&context=3

-- Capture real implementation of function that sets signs
local orig_set_signs = vim.lsp.diagnostic.set_signs
local set_signs_limited = function(diagnostics, bufnr, client_id, sign_ns, opts)
  -- original func runs some checks, which I think is worth doing
  -- but maybe overkill
  if not diagnostics then
    diagnostics = diagnostic_cache[bufnr][client_id]
  end

  -- early escape
  if not diagnostics then
    return
  end

  -- Work out max severity diagnostic per line
  local max_severity_per_line = {}
  for _, d in pairs(diagnostics) do
    if max_severity_per_line[d.range.start.line] then
      local current_d = max_severity_per_line[d.range.start.line]
      if d.severity < current_d.severity then
        max_severity_per_line[d.range.start.line] = d
      end
    else
      max_severity_per_line[d.range.start.line] = d
    end
  end

  -- map to list
  local filtered_diagnostics = {}
  for _, v in pairs(max_severity_per_line) do
    table.insert(filtered_diagnostics, v)
  end

  -- call original function
  orig_set_signs(filtered_diagnostics, bufnr, client_id, sign_ns, opts)
end
vim.lsp.diagnostic.set_signs = set_signs_limited
