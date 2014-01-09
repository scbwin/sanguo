require "luascripts/extern"

Mercenary = class("Mercenary")
Mercenary.__index = Mercenary
Mercenary.m_id = 0
Mercenary.m_name = ''
Mercenary.m_level = 0
Mercenary.m_property = 0
Mercenary.m_basehp = 0
Mercenary.m_basemp = 0
Mercenary.m_baseattack = 0
Mercenary.m_basespattack = 0
Mercenary.m_basedefend = 0
Mercenary.m_basespdefend = 0
Mercenary.m_basecritical = 0
Mercenary.m_basedefcritical = 0
--parry 格挡
Mercenary.parry = 0
Mercenary.defparry = 0

function Mercenary:Init()
end

function Mercenary:getLevel()
	return Mercenary.level
end

function Mercenary:getBaseHp()
	return Mercenary.basehp
end

function Mercenary:getBaseMp()
	return Mercenary.basemp
end

function Mernary:getProperty()
	return Mercenary.property
end

function Mercenary:getBaseAttack()
	return Mercenary.baseattack
end

function Mercenary:getBaseSpAttack()
	return Mernary:baseattack
end

function Mercenary:getBaseDefend()
	return Mernary.basedefend
end

function Mercenary:getBaseSpDefend()
	return Mernary.spbasedefend
end