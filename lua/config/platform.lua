local M = {}

M.system = vim.uv.os_uname().sysname
M.is_windows = M.system == "Windows_NT"
M.is_mac = M.system == "Darwin"
M.is_linux = M.system == "Linux"

-- Read an executable's location from PATH without assuming a platform-specific
-- extension such as .exe.
function M.executable(command)
    return vim.fn.executable(command) == 1
end

return M
