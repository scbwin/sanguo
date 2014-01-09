require "luascripts/extern"
--battle type start
BATTLE_DEMO  = 1
BATTLE_STORY = 2
--battle type end

--damage type start
PHY_NORMAL = 1
PHY_SKILL = 2
MAG_NORMAL =3
MAG_SKILL = 4
--damage type end

Buff = class("Buff")
Buff.__index = Buff
Buff.idx = 0
Buff.type = 0
Buff.param = 0
Buff.time = 0
Buff.val = 0
Buff.val1 = 0

function Buff:applyEffect(fighter)
	if self.type == BUFF_EFFECT_HP then 
		fighter.HP = fighter.HP + self.param 
		self.val = self.param 
	elseif self.type == BUFF_EFFECT_ATK_P then 
	    self.val = self.param 
	elseif self.type == BUFF_EFFECT_ATK_M then 
		self.val = self.param 
	elseif self.type == BUFF_EFFECT_ATK_ALL then
		self.val = self.param
	elseif self.type == BUFF_EFFECT_DEF_P then 
		self.val = self.param
	elseif self.type == BUFF_EFFECT_DEF_M then 
		self.val = self.param 
	elseif self.type == BUFF_EFFECT_DEF_ALL then 
		self.val = self.param
	elseif self.type == BUFF_EFFECT_HP_P then 
		self.val = self.param
	elseif self.type == BUFF_EFFECT_ATK_P_P then 
		self.val = self.param
	elseif self.type == BUFF_EFFECT_ATK_M_P then 
		self.val = self.param 
	elseif self.type == BUFF_EFFECT_ATK_ALL_P then 
		self.val = self.param 
	elseif self.type == BUFF_EFFECT_DEF_P_P then 
		self.val = self.param
	elseif self.type == BUFF_EFFECT_DEF_M_P then
		self.val = self.param
	elseif self.type == BUFF_EFFECT_DEF_ALL_P then 
		self.val = self.param 
	elseif self.type == BUFF_EFFECT_STUN then 
		self.val = self.param
	end
end

function Buff:removeEffect(fighter)
	if self.type == BUFF_EFFECT_HP then 
		fighter.HP = fighter.HP + self.param 
		self.val = self.param 
	elseif self.type == BUFF_EFFECT_ATK_P then 
	    self.val = self.param 
	elseif self.type == BUFF_EFFECT_ATK_M then 
		self.val = self.param 
	elseif self.type == BUFF_EFFECT_ATK_ALL then
		self.val = self.param
	elseif self.type == BUFF_EFFECT_DEF_P then 
		self.val = self.param
	elseif self.type == BUFF_EFFECT_DEF_M then 
		self.val = self.param 
	elseif self.type == BUFF_EFFECT_DEF_ALL then 
		self.val = self.param
	elseif self.type == BUFF_EFFECT_HP_P then 
		self.val = self.param
	elseif self.type == BUFF_EFFECT_ATK_P_P then 
		self.val = self.param
	elseif self.type == BUFF_EFFECT_ATK_M_P then 
		self.val = self.param 
	elseif self.type == BUFF_EFFECT_ATK_ALL_P then 
		self.val = self.param 
	elseif self.type == BUFF_EFFECT_DEF_P_P then 
		self.val = self.param
	elseif self.type == BUFF_EFFECT_DEF_M_P then
		self.val = self.param
	elseif self.type == BUFF_EFFECT_DEF_ALL_P then 
		self.val = self.param 
	elseif self.type == BUFF_EFFECT_STUN then 
		self.val = self.param
	end
end

BuffList = class("BuffList")
BuffList.__index = BuffList
BuffList.buff = {}

function BuffList:clear()

end

function BufferList:get()

end

function BufferList:push(buf)
end

function BufferList:free()
end

SkillEffect = class("SkillEffect")
SkillEffect.__index = SkillEffect
SkillEffect.id = 0
SkillEffect.chance = 0
SkillEffect.target = 0
SkillEffect.baseDamage = 0
SkillEffect.effectType = 0
SkillEffect.effectParam1 = 0
SkillEffect.effectParam2 = 0
SkillEffect.effectParam3 = 0



FightData = class("FightData")
FightData.__index = FightData
FightData.name =""
FightData.SoulID = 0
FightData.Level = 0
FightData.isMob = false
FightData.Team = 0
FightData.TotalHP = 0
FightData.Race = 0
FightData.Power = 0
FightData.HP = 0
FightData.ATK_TYPE = 0
FightData.ATK = 0
FightData.DEF_P = 0
FightData.DEF_M = 0
FightData.StunCounter = 0
FightData.atkSkillCount = 0
FightData.defenceSkillCount = 0
FightData.attackSkill = {}
FightData.defenceSkill = {}
FightData.buff = nil
FightData.delegate = nil




function FightData:beHurt(other, rand)

end

function FightData:initWithFighter(fighter)

end

function FightData:initWithMonster(monster_id, lv)

end

function FightData:calcDamage(other, rand)
end

function FightData:addBuff(type, val, time)
end

function FightData:updateBuff()
end

Team = class("Team")
Team.__index = Team
Team.name = ""
Team.idx = 0
Team.count = 0


Battle = class("Battle")
Battle.__index = Battle
Battle.teams = {}
Battle.rand = nil
Battle.m_delegate = nil

function Battle:fight(seed)
	rand.setSeed(seed)

	self.teams[0].idx = 0
	self.teams[1].idx = 0

	BattleCmd cmd
	while true do 
		attacker = self.teams[0].member[self.teams[0].idx]
		defender = self.teams[1].member[self.teams[1].idx]
		if attacker.Power < defender.Power then 
		    temp = attacker
		    attacker = defender
		    defender = temp
		end
		attacker.delegate = self.m_delegate
		defender.delegate = self.m_delegate

		cmd.cmd = BattleCmd::JOIN
		cmd.time = 2.0
		cmd.data.join.isMob = attacker.isMob
		cmd.data.join.SoulID = attacker.SoulID
		cmd.data.join.Level = attacker.Level
		cmd.data.join.attacker = true
	end



end

function Battle:initForDemo(demoid)
	battlecfg = GameConfig:findCfg(demoid)

	teamA = Team:new()
end

function Battle:setDelegate(delegate)
	self.m_delegate = delegate
end

function Battle:getTeamName(team)
	return teams[team].name
end

function Battle:getTeamMemberCount(team)
	return teams[team].count
end

function Battle:getFightData(team,member)
	return teams[team].member[member]
end
