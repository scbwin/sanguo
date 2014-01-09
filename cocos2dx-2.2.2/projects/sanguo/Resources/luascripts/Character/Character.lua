require "luascripts/extern"
--mercenary 佣兵
Character = class("Character")
Character.__index = Character
Character.m_mercenaryTable = {}
Character.m_mercenaryTotalNum = 0
Character.m_name = ""
Character.m_level = 0
Character.m_mercenaryActiveNum = 0

function Character:addMercenary(mercenary)
	table.insert(Character.m_mercenaryTable,mercenary)
	self.m_mercenaryTotalNum = self.m_mercenaryTotalNum + 1
end

function Character:removeMercenary(mercenary)
	for i = 1, #self.m_mercenaryTable do
		if self.m_mercenaryTable[i] == mercenary
			table.remove(self.m_mercenaryTable,i)
		end
	end
end

function Character:getMercenaryTable()
	return self.m_mercenaryTable
end

function Character:getMercenaryNum()
	return self.m_mercenaryTotalNum
end

function Character:setName(name)
	self.m_name = name
end

function Character:getName()
	return self.m_name
end

function Character:setLevel(level)
	self.m_level = level
end

function Character:getLevel()
	return self.m_level
end

function Character:activeMercenaryByIndex(index)
	self.m_mercenaryActiveNum = self.m_mercenaryActiveNum + 1
	local mercenary = self.m_mercenaryTable[index]
	mercenary:setActive()

function Character:activeMercenaryById(id)
	self.m_mercenaryActiveNum = self.m_mercenaryActiveNum + 1
	local mercenary = self:findMercenaryById(id)
end

function Character:deactiveMercenaryByIndex(index)
	self.m_mercenaryActiveNum = self.m_mercenaryActiveNum - 1
end

function Character:deactiveMercenaryById(id)
	local mercenary = self:findMercenaryById(id)

end