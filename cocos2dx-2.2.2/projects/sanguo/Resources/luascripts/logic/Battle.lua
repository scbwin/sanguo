require "luascripts/extern"
require "luascripts/base/GameConfig.lua"
require "luascripts/utils/utils.lua"
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

function BuffList:get()

end

function BuffList:push(buf)
end

function BuffList:free()
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
function FightData:ctor()
	self.name =""
	self.SoulID = 0
	self.Level = 0
	self.isMob = false
	self.Team = 0
	self.TotalHP = 0
	self.Race = 0
	self.Power = 0
	self.HP = 0
	self.ATK_TYPE = 0
	self.ATK = 0
	self.DEF_P = 0
	self.DEF_M = 0
	self.StunCounter = 0
	self.atkSkillCount = 0
	self.defenceSkillCount = 0
	self.attackSkill = {}
	self.defenceSkill = {}
	self.buff = nil
	self.delegate = nil
	self.posIndex = 0
	self.speed = 0
	self.time = 0
	self.roundtime = 0
end


--[[

function FightData:beHurt(other, rand)
	BattleCmd Atkcmd
	BattleCmd HitCmd
	AtkCmd.cmd = BattleCmd::ATTACK
	AtkCmd.time = 1.5
	AtkCmd.data.attack.damage = 0
	AtkCmd.data.attack.skill = INVALID_ID

	HitCmd.cmd = BattleCmd::HIT
	HitCmd.time = 2.0
	HitCmd.data.hit.damage = 0
	HitCmd.data.hit.skill = INVALID_ID

	if other.StunCounter > 0 then
		cclog("[%s]处于眩晕中，跳过攻击", other.name)
		return false
	end

	damage = other:calcDamage(self,rand)

	skill = other:randomAtSkill(rand)
	if skill ~= nil then
		damage = damage * skill.baseDamage /100
		AtkCmd.data.attack.skill  = skill.id
	end

	defSkill = self:randomDefSkill(rand)
	dodge = false
	immunity_buff = false

	if defSkill ~= nil then
		HitCmd.data.hit.skill = defSkill.id
		if defSkill.effectType == DEF_SKILL_EFFECT_ADD_BUFF then
			if defSKill.target == SKILL_TARGET_TYPE_SELF then
				other.addBuff(defSkill.effectParam1,defSkill.effectParam2,defSkill.effectParam3)
			elseif defSkill.target == SKILL_TARGET_TYPE_ENEMY then
				self:addBuff(defSkill.effectParam1, defSkill.effectParam2,defSkill.effectParam3)
			end
		elseif defSkill.effectType == DEF_SKILL_EFFECT_ATK_BACK then
			td = self:calcDamage(other, rand)
			AtkCmd.data.attack.damage = td
			other.HP -= td
		elseif defSkill.effectType == DEF_SILL_EFFECT_DMG_REBOUND then
			td = damage * defSkill.effectParam1 /100
			AtkCmd.data.attack.damage = td
			other.HP -= td
		elseif defSkill.effectType == DEF_SKILL_EFFECT_DMG_MULT then
			print("DEF_SKILL_EFFECT_DMG_MULT")
		elseif defSkill.effectType == DEF_SKILL_EFFECT_DODGE then
			self.dodge = true
		elseif defSKill.effectType == DEF_SKILL_EFFECT_IMMUNITY_BUFF then
			self.immunity_buff = true
		elseif defSkill.effectType == DEF_SKILL_EFFECT_IMMUNITY_GROUP_1 then 
			immunity_group = true
		end
	end

	if not dodge then
		if self.skill ~= nil then
			if skill.effectType == ATK_SKILL_EFFECT_ADD_BUFF then
				if not immunity_buff then
					if skill.target == SKILL_TARGET_TYPE_SELF then
						other.addBuff(skill.effectParam1, skill.effectParam2, skill.effectParam3)
					elseif skill.target == SKILL_TARGET_TYPE_ENEMY then
						addBuff(skill.effectParam1, skill.effectParam2,skill.effectParam3)
					end
				end
			elseif skill.effectType == ATK_SKILL_EFFECT_DMG_MULT then
				if not immunity_group then
					damage = damage * skill.effectParam1 /100
				end
			elseif skill.effectType == ATK_SKILL_EFFECT_VAMPIRE then
				hp = damage * skill.effectParam1 / 100
				other.HP = other.HP + hp
				AtkCmd.data.attack.damage = AtkCmd.data.attack.damage - hp
			elseif skill.effectType == ATK_SKILL_EFFECT_ATK_MULT then
				if not immunity_group2 then
					damage = damage + other.calcDamage(self, rand)
				end
			end
		end
		HP = HP - damage
		HitCmd.data.hit.damage = damages
	end

	AtkCmd.cmd = BattleCmd.BEFORE_ATK
	AtkCmd.time = 0.5
	AtkCmd.data.attack.damage = AtkCmd.data.attack.damage - (AtkCmd.data.attack.damage / VAL_BASE)
end

function FightData:initWithFighter(fighter)

end

function FightData:initWithMonster(monster_id, lv)

end

function FightData:calcDamage(other, rand)
end

function FightData:addBuff(type, val, time)
	local buf = self.buff.get()
	if bul ~= nil then 
		cclog("[%s]获得BUFF %d 参数%d 回合%d", self.name, self.type,self.val, self.time)
		buf.type = type
		buf.param = val
		buf.time = time
		buf:applayEffect(self)
end

function FightData:updateBuff()
end
]]--
Team = class("Team")
Team.__index = Team

function Team:ctor()
	self.name = ""
	self.idx = 0
	self.count = 0
	self.member = {}
end



Battle = class("Battle")
Battle.__index = Battle
function Battle:ctor()
	self.teams = {}
	self.rand = SRandom:new()
	self.m_delegate = nil
	self.time = 0
	self.attck = false
end

--[[
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
]]--
function Battle:initForDemo(demoid)
	--battlecfg = GameConfig:findCfg(demoid)

	teamA = Team:new()
	teamA.count = 0
	teamA.name = "player"
	for i = 1, GameCfg.TEAM_SIZE_MAX , 1 do
		teamA.member[i] = FightData:new()
		teamA.member[i].name = "player" .. i
		teamA.member[i].Team = 1
		teamA.member[i].speed = 100 + 20 * i 
		teamA.member[i].roundtime = (500 - teamA.member[i].speed ) * 0.01 + 1
		teamA.member[i].time = 0
		teamA.count = teamA.count + 1
	end

	
	self.teams[1] = teamA
	--print("team A member" .. 0 .. " name is " .. self.teams[1].member[1].name)
	teamB = Team:new()
	teamB.count = 0
	teamB.name = "enemy"
	for i = 1, GameCfg.TEAM_SIZE_MAX , 1 do
		--print("0team A member" .. 0 .. " name is " .. self.teams[1].member[i].name)
		
		teamB.member[i] = FightData:new()
		teamB.member[i].name = "enemy" .. i
		teamB.member[i].Team = 2
		teamB.member[i].speed = 100 + 30 * i
		teamB.member[i].roundtime = (500 - teamB.member[i].speed ) * 0.01 + 1
		teamB.member[i].time = 0
		teamB.count = teamB.count + 1
	end
	--print("team A member" .. 0 .. " name is " .. self.teams[0].member[0].name)
	self.teams[2] = teamB
	--print("team A member" .. 0 .. " name is " .. self.teams[0].member[0].name)

end

function Battle:update(dt)
	--print("team A count is " .. self.teams[0].count)
	--print("team A name is " .. self.teams[0].name)
	--print("test rand = " .. self.rand:nextDouble())
	local attackteam = {}
	local defteam = {}
	if not self.attack then
	self.time = self.time + dt
	for i = 1, self.teams[1].count, 1 do
		--print("team A member" .. i .. " name is " .. self.teams[1].member[i].name)
		self:getFightData(1,i).time = self:getFightData(1,i).time + dt
		if self:getFightData(1,i).time > self:getFightData(1,i).roundtime then
			attackteam[#attackteam + 1] = i
		end
	end
	--print("team B count is " .. self.teams[1].count)
	--print("team B name is " .. self.teams[1].name)
	for i = 1, self.teams[2].count , 1 do
		--print("team B member" .. i .. " name is " .. self.teams[2].member[i].name)
		self.teams[2].member[i].time = self.teams[2].member[i].time + dt
		if self.teams[2].member[i].time > self.teams[2].member[i].roundtime then
			defteam[#defteam + 1] = i
		end
	end
	if #attackteam > 0 and #defteam > 0 then 
		if #attackteam > 1 and #defteam > 1 then
			cclog("combo attack start")
			for i = 1, #attackteam, 1 do 
				cclog("player %d attack",attackteam[i])
			end
			cclog("combo attack end")
		end

		elseif #attackteam > 1 and #defteam == 1 then 
		elseif #defteam > 1 and #attackteam == 1 then
		elseif #attackteam == 1 and #defteam == 1 then
		else
			print("Battle:update error!!!")
		end
	elseif #attackteam > 1 then 
	elseif #defteam > 1 then 
	elseif #attackteam == 1 then
	elseif #defteam == 1 then
	end
end

function Battle:AI(dt)
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
	return self.teams[team].member[member]
end
