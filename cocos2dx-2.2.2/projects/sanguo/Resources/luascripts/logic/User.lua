require "luascripts/extern"
--mercenary 佣兵
User = class("User")
User.__index = User


function User:runBattle(type,id,seed,delegate)
	if type == BATTLE_DEMO then
		runDemoBattle(id,seed,delegate)
	elseif type == BATTLE_STORY then 
		runStoryBattle(id,seed,delegate)
	end 
end
function User:runDemoBattle(demoID,seed,delegate)
	m_lastBattleResult.replay = true
	m_Battle.initForDEMO(demoID)
	m_Battle.setDelegate(delegate)
	m_Battle.fight(seed)
end

function User:runStoryBattle(storyID, seed, delegate)
	m_lastBattleResult.replay = true
	m_Formation.updateAll()
	m_Battle.initForStory(m_Formation.getData(), storyID)
	m_Battle.setDelegate(delegate)
	m_Battle.fight(seed)
end
