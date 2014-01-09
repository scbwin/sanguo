require "luascripts/extern"
--mercenary 佣兵
MainCharacer = class("MainCharacer",Character)
MainCharacer.__index = Character

MainCharacer.m_mercenary = {}
MainCharacer.m_mercenaryTotalNum = 0
MainCharacer.m_name = ""
MainCharacer.m_level = 0
MainCharacer.m_mercenaryActiveNum = 0




