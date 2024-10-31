local function detect_os()
	-- Check for Windows environment
	local os_name = os.getenv("OS")
	if os_name and os_name:find("Windows") then
		return "Windows"
	else
		-- Use `uname` command for Unix-like OS detection
		local handle = io.popen("uname")

		-- Check if the handle was successfully created
		if not handle then
			return "Unknown OS" -- Could not execute `uname`, so OS is unknown
		end

		local result = handle:read("*a")
		handle:close()

		if result:find("Darwin") then
			return "macOS"
		elseif result:find("Linux") then
			return "Linux"
		else
			return "Unknown OS"
		end
	end
end

return detect_os()
