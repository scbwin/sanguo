local emitter
local drawlayer = nil
local sptemp = nil
local sp = {}
local zy = {}
local startindex = 0
local moveiindex = 0
local spindex = 0
local nodes = {}
local redobtn = nil 
local savebtn = nil
local function values(t)
	local i = 0
	return function () i = i + 1; return t[i] end 
end

local function ontouchEvent(eventType)
	if eventType == "pushDown" then
		--if emitter ~= nil then 
		--	emitter:setLife(1)
		--	emitter = nil 
		--end
		--emitter = CCParticleSystemQuad:create("magicFire.plist")
   	 	--emitter:setDuration(-1)
   	 	--emitter:setPosition(ccp(zy1:getTouchStartPos().x,zy1:getTouchStartPos().y))
   	 	--zy1:addChild(emitter)
   	 	---CCDirector:sharedDirector():getRunningScene():addChild(emitter)
   	 	if drawlayer ~= nil then 
   	 		local startx = 0
   	 		local starty
   	 		for i = 1,5 do
   	 			if zy[i]:isFocused()  then 
   	 				startindex = i
   	 				moveindex = i
   	 				for i = 1, #nodes do
   	 					if nodes[i] == node then
   	 						table.remove(nodes, i)
   	 					end
   	 				end
   	 			end
   	 		end
   	 		sptemp = CCSprite:create("image/emptyhuoli.png")
   	 		sptemp:setPosition(zy[startindex]:getWorldPosition())   --.x,zy[startindex]:getWorldPosition().y
   	 		sptemp:setVisible(false)
   	 		drawlayer:addChild(sptemp)
   	 	end
	elseif eventType == "move" then 
		--ccDrawSolidRect(ccp(0,0), ccp(50,120),ccc4f(0.5, 0.5, 1, 1 ))
		--emitter:setPosition(ccp(zy1:getTouchMovePos().x,zy1:getTouchMovePos().y))
		if sptemp ~= nil then
			for node in values(nodes) do
				if zy[node]:hitTest(ccp(zy[startindex]:getTouchMovePos().x,zy[startindex]:getTouchMovePos().y)) and node ~= moveindex and node ~= startindex then
					spindex = spindex + 1 
					sp[spindex] = CCSprite:create("image/emptyhuoli.png")
					local endpoint 	 = tolua.cast(zy[node]:getWorldPosition(),"CCPoint")
					local startpoint = tolua.cast(zy[moveindex]:getWorldPosition(),"CCPoint")
					local length = ccpLength(ccpSub(endpoint, startpoint))
					minpos = ccpMidpoint(endpoint,startpoint)
					sp[spindex]:setPosition(minpos)
					local degree = -math.deg(math.atan(
					(endpoint.y - startpoint.y)/(endpoint.x - startpoint.x)
					))
					sp[spindex]:setRotation(degree)
					sp[spindex]:setScaleX(length /212)
					sp[spindex]:setScaleY(0.3)
   		 			drawlayer:addChild(sp[spindex])
   	 				moveindex = node
   	 				for i = 1, #nodes do
   	 					if nodes[i] == node then
   	 						table.remove(nodes, i)
   	 					end
   	 				end
   	 				 local fade = CCSequence:createWithTwoActions(
		CCScaleTo:create(0.15, 1.3),
		CCScaleTo:create(0.15, 1.0))

   	 				local curnode = zy[node]:getVirtualRenderer()
   	 				curnode:runAction(fade)
				end
			end
			sptemp:setVisible(true)
			local endpoint 	 = tolua.cast(zy[startindex]:getTouchMovePos(),"CCPoint")
			local startpoint = tolua.cast(zy[moveindex]:getWorldPosition(),"CCPoint")
			local length = ccpLength(ccpSub(endpoint, startpoint))
			sptemp:setPosition(ccpMidpoint(endpoint,startpoint))
			local degree = -math.deg(math.atan(
					(endpoint.y - startpoint.y)/(endpoint.x - startpoint.x)
				))
			sptemp:setRotation(degree)
			sptemp:setScaleX(length /212)
			sptemp:setScaleY(0.3)
		end
	elseif eventType == "releaseUp" then 
		--emitter:setPosition(ccp(zy1:getTouchEndPos().x,zy1:getTouchEndPos().y))
		--emitter:setDuration(1)
		--emitter = nil
		if sptemp ~= nil then 
			drawlayer:removeChild(sptemp,true)
			sptemp = nil
		end 
	elseif eventType =="cancelUp" then 
		if sptemp ~= nil then 
			drawlayer:removeChild(sptemp,true)
			sptemp = nil
		end
	end

end

local function redoEvent(eventType)
	if eventType == "pushDown" then
		for i = 1, 5 do 
			if sp[i] ~= nil then 
				drawlayer:removeChild(sp[i], true)
			end 
		end
		if sptemp ~= nil then 
			drawlayer:removeChilde(sptemp,true)
		end 
		for i = 1, 5 do
			zy[i]:unregisterEventScript()
			zy[i]:onTouchBegan(ccp(0,0))
			zy[i]:onTouchMoved(ccp(0,0))
			zy[i]:onTouchEnded(ccp(0,0))
			zy[i]:onTouchCancelled(ccp(0,0))
			zy[i]:registerEventScript(ontouchEvent)
		end
		spindex = 0
		startindex = 0
		moveindex = 0
		nodes = {}
		for i = 1, 5 do
			table.insert(nodes,i)
		end
	end
end

local function saveEvent(eventType)
	if eventType == "pushDown" then
	end
end

function addPage3CallBack(uilayer)
	print("init page3 callback")
	drawlayer = uilayer
	for i = 1, 5 do
		sp[i] = nil
		zy[i] = nil
		table.insert(nodes,i)
	end
	for i = 1, 5 do
		zy[i] = uilayer:getWidgetByName("mf2zy" .. i)
		zy[i]:unregisterEventScript()
		zy[i]:onTouchBegan(ccp(0,0))
		zy[i]:onTouchMoved(ccp(0,0))
		zy[i]:onTouchEnded(ccp(0,0))
		zy[i]:onTouchCancelled(ccp(0,0))
		zy[i]:registerEventScript(ontouchEvent)
	end
	redobtn = uilayer:getWidgetByName("redo_btn")
	redobtn:registerEventScript(redoEvent)
	savebtn = uilayer:getWidgetByName("save_btn")
	savebtn:registerEventScript(saveEvent)
	spindex = 0
	startindex = 0
	moveindex = 0
end