function include(module)
	local fileUtils = CCFileUtils:getInstance()
	local mainPath = fileUtils:fullPathForFilename("main.lua")
	scriptPath = string.sub(mainPath, 1, #mainPath - 9)
	local modulePath = scriptPath .. "/" .. module
	fileUtils:addSearchPath(modulePath)
	require(module)
end

--include("")
--nclude("")