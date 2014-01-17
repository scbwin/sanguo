require "luascripts/extern"
require "luascripts/UI/Battle/BattleUIConf.lua"
require "luascripts/logic/Battle.lua"
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
BattleUI.icons = {}
BattleUI.battle = nil


function BattleUI:update(dt)
	--print("test update")
	self.count = self.count + 1
	self.battle:update(dt)
end

function BattleUI:init()
	self:scheduleUpdateWithPriorityLua(function(dt) self:update(dt) end,0)
	self.battle = Battle:new()
	self.battle:initForDemo(0)

end

function BattleUI:create()
	battle = BattleUI:new()
	battle:init()
	local scenenode = SceneReader:sharedSceneReader():createNodeWithSceneFile("gamefight.json")    --"gamefight.json"
	if nil == scenenode then 
		return 
	end
	self.sceneNode = scenenode
	local uinode = scenenode:getChildByTag(SCENEUI)
	local node = (tolua.cast(uinode,"CCNode")):getComponent("GUIComponent")
	self.uiNode = tolua.cast(tolua.cast(node, "CCComRender"):getNode(), "TouchGroup")
	
	self:setHeadIcon(PLAYER,"icon/head01.png")
	self:setHeadIcon(ENEMY,"icon/head01.png")
	self:setHpTotalProcess(PLAYER,16)
	self:setHpTotalProcess(ENEMY,16)
	self:setSkillIcon(1,"icon/head01.png")
	self:setPlayerHp(1,15)
	self:setPlayerHp(2,25)
	self:setPlayerHp(3,35)
	self:setPlayerHp(4,45)
	self:setPlayerHp(5,55)
	self:setRage(214)

	self:setPlayerArmature(1,1)
	self:setPlayerArmature(1,2)
	self:setPlayerArmature(1,3)
	self:setPlayerArmature(1,4)
	self:setPlayerArmature(1,5)
	self:setPlayerArmature(1,6)
	self:setPlayerArmature(1,7)
	self:setPlayerArmature(1,8)
	self:setPlayerArmature(1,9)
	

	tolua.cast(battle, "CCScene"):addChild(scenenode)
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
	print("content size is " .. srcContent.width .. "," .. srcContent.height)
	rt = CCRenderTexture:create(srcContent.width, srcContent.height, kCCTexture2DPixelFormat_RGBA8888)
	local srcBlendFunc = ccBlendFunc:new()
    srcBlendFunc.src = GL_DST_ALPHA
    srcBlendFunc.dst = GL_ZERO
	local maskBlendFunc = ccBlendFunc:new()
	maskBlendFunc.src = GL_ONE
	maskBlendFunc.dst = GL_ZERO
	--maskpos = ccp(mask:getPosition())
	--srcpos = ccp(src:getPosition())
	--maskanchorPos = mask:getAnchorPoint()
	--srcanchorPos = src:getAnchorPoint()
	mask:setAnchorPoint(ccp(0,0))
	src:setAnchorPoint(ccp(0,0))
	mask:setBlendFunc(maskBlendFunc)
	src:setBlendFunc(srcBlendFunc)
	--print("mask pos = " .. maskpos.x .. "," .. maskpos.y )
	--print("src pos = " .. srcpos.x .. "," .. srcpos.y )
	--print("mask anchorpos = " .. maskanchorPos.x .. "," .. maskanchorPos.y )
	--print("src anchorpos = " .. srcanchorPos.x .. "," .. srcanchorPos.y )
	rt:begin()
	mask:visit()
	src:visit()
	rt:endToLua()
	retval = CCSprite:createWithTexture(rt:getSprite():getTexture())
	retval:setFlipY(true)
	return retval
end

function BattleUI:setHeadIcon(team,icon)
	if self.uiNode ~= nil then
		local headback = CCSprite:create(HEADBACK)
		local widget = nil
		local sprite = self:createMaskedSprite(icon, mask01)
		if team == PLAYER then
			widget = self.uiNode:getWidgetByName(PLAYERHEAD)
		elseif team == ENEMY then 
			widget = self.uiNode:getWidgetByName(ENEMYHEAD)
			sprite:setFlipX(true)
		end 
		local pos = widget:getWorldPosition()
		--print("pos = " .. pos.x .. "," .. pos.y)
		--local sprite = CCSprite:create("icon/head01.png")
		sprite:setPosition(pos)
		headback:setPosition(pos)
		--sprite:setAnchorPoint(ccp(0,0))
		sprite:setZOrder(5)
		headback:setZOrder(4) 
		self.uiNode:addChild(headback)
		self.uiNode:addChild(sprite)
	end
end

function BattleUI:setSkillIcon(index,icon)
	if self.uiNode ~= nil then
		name = SKILLBOX .. index
		local widget = self.uiNode:getWidgetByName(name)
		local pos = widget:getWorldPosition()
		local sprite = self:createMaskedSprite(icon, mask02)
		sprite:setScale(0.73)
		sprite:setPosition(pos)
		sprite:setZOrder(5)
		self.uiNode:addChild(sprite)
	end
end

function BattleUI:setHpTotalProcess(team,hp)
	if self.uiNode ~= nil then
		local widget = nil
		if team == PLAYER then
			widget = self.uiNode:getWidgetByName(PLAYERTOTALHP)
		elseif team == ENEMY then 
			widget = self.uiNode:getWidgetByName(ENEMYTOTALHP)
		end
		tolua.cast(widget,"LoadingBar"):setPercent(hp)
	end
end

function BattleUI:setPlayerHp(index, hp)
	if self.uiNode ~= nil then
		name = PLAYERHP .. index
		local widget = self.uiNode:getWidgetByName(name)
		tolua.cast(widget,"LoadingBar"):setPercent(hp)

	end
end

function BattleUI:setSkillBar(index, percent)
	if self.uiNode ~= nil then
		name = SKILLBAR .. index
		local widget = self.uiNode:getWidgetByName(name)
		tolua.cast(widget, "LoadingBar"):setPercent(percent)
	end
end

function BattleUI:setRage(num)
	assert(num <= 300,"Rage is large than 300")
	assert(num >=0, "Rage is small than 0 ")
	if num >= 0 and num <= 100 then
		self:setSkillBar(1,num)
		self:setSkillBar(2,0)
		self:setSkillBar(3,0)
	elseif num >100 and num <= 200 then
		self:setSkillBar(1,100)
		self:setSkillBar(2,num - 100)
		self:setSkillBar(3,0)
	elseif num >200 and num <= 300 then 
		self:setSkillBar(1,100)
		self:setSkillBar(2,100)
		self:setSkillBar(3,num -200)
	end 
end

function BattleUI:setPlayerSpeedBarIcon(icon, arrow)
	local headicon = CCSprite:create(icon)
	local arrowicon = CCSprite:create(arrow)

end

function BattleUI:setPlayerArmature(anim, index)
	local playertag = PLAYER1 + index -1
	local playernode = self.sceneNode:getChildByTag(playertag)
	CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfo("zf/zf0.png", "zf/zf0.plist","zf/zf.ExportJson")
	local armature = CCArmature:create("zf")
	if playernode == nil then 
		print("index is " .. index)
	end
	local pos = ccp(playernode:getPosition())
	armature:setPosition(pos)
	armature:getAnimation():playWithIndex(0)
	armature:setScale(0.5)
	armature:setZOrder(10)
	self.sceneNode:addChild(armature)
end

function BattleUI:setEnemyArmature(anim, index)
end