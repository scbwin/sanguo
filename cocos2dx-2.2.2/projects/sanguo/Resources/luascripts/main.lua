require "luascripts/UI/LayerLogin/LayerLogin"
require "luascripts/UI/buzhen/buzhen.lua"
require "luascripts/UI/Battle/BattleUI.lua"
require "luascripts/utils/utils.lua"
require "luascripts/logic/Battle.lua"
-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(msg) .. "\n")
    print(debug.traceback())
    print("----------------------------------------")
end



function SceneUpdate()
end
local function main()
	collectgarbage("setpause", 100) 
	collectgarbage("setstepmul", 5000)
	
	--scene:addChild(LayerLogin())
	--scene:addChild(buzhen())
	
	--local layer = CCLayer:create()
	local scene = BattleUI:scene()
	--layer:addChild(tolua.cast(scenenode,"CCNode"))
	-- add armature code start
	--[[CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfo("iceman0.png", "iceman0.plist","iceman.ExportJson")
	local armature = CCArmature:create("iceman")
	armature:setPosition(ccp(100,100))
	armature:getAnimation():playByIndex(0)
	armature:setScale(1)
	armature:setZOrder(10)
	layer:addChild(armature)
	-- add armature code end]]
	
	CCDirector:sharedDirector():replaceScene(scene)
end

xpcall(main, __G__TRACKBACK__)