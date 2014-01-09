require "luascripts/extern"
local battle = nil
BattleUI = class("BattleUI",function()
		return CCLayer:create()
	end
)
BattleUI.__index = BattleUI
BattleUI.time = 0
BattleUI.playerTeam = {}
BattleUI.enemyTeam = {}
BattleUI.sceneNode = nil
BattleUI.uiNode = nil
BattleUI.count = 0

local function update(dt)
	print("test update")
	battle.count = battle.count + 1
end

function BattleUI:init()
	self:scheduleUpdateWithPriorityLua(update,0)
end

function BattleUI:create()
	battle = BattleUI:new()
	battle:init()
	self.sceneNode = SceneReader:sharedSceneReader():createNodeWithSceneFile("gamefight.json")    --"gamefight.json"
	local uinode = self.sceneNode:getChildByName("SceneUI")
	local node = (tolua.cast(uinode,"CCNode")):getComponent("GUIComponent")
	local ui = node:getNode()
	--self.uiNode = (tolua.cast(self.sceneNode,"CCNode")):getComponent("GUIComponent"):getNode()

	battle:addChild(tolua.cast(self.sceneNode,"CCNode"))
	return battle
end

function BattleUI:scene()
	local scene = CCScene:create()
	local battlelayer = BattleUI:create()
	scene:addChild(tolua.cast(battlelayer,"CCLayer"))
	return scene
end

function BattleUI:createMaskedSprite(srcSprite, maskSprite)
	local src = CCSprite:create(srcSprite)
	local mask = CCSprite:create(maskSprite)
	srcContent = src:getContentSize()
	rt = CCRenderTexture:create(srcContent.width, srcContent.height, kCCTexture2DPixelFormat_RGBA8888)
	local srcBlendFunc = ccBlendFunc:new()
    srcBlendFunc.src = GL_DST_ALPHA
    srcBlendFunc.dst = GL_ZERO
	--srcBlendFunc = { GL_DST_ALPHA, GL_ZERO}
	--maskBlendFunc = {GL_ONE, GL_ZERO}
	local maskBlendFunc = ccBlendFunc:new()
	maskBlendFunc.src = GL_ONE
	maskBlendFunc.dst = GL_ZERO
	rt:begin()
	mask:visit()
	src:visit()
	rt:endToLua()
	retval = CCSprite:createWithTexture(rt:getSprite():getTexture())
	retval:setFilpY(true)
	return retval
end

function BattleUI:setPlayerHeadIcon(icon)
	if self.uiNode ~= nil then
		local playerhead = self.uiNode:getWidgetByName("PlayerHead")
		local pos = playerhead:getPosition()
	end
end

function BattleUI:setEnemyHeadIcon(icons)

end

function BattleUI:setPlayerArmature(anim, index)

end

function BattleUI:setEnemyArmature(anim, index)
end

function BattleUI:setPlayerHP(hp)
end

function BattleUI:setEnemyHP(hp)
end