require "luascripts/extern"
--mercenary 佣兵
CharacterMgr = class("CharacterMgr",Character)
CharacterMgr.__index = CharacterMgr

CharacterMgr.m_mercenary = {}
CharacterMgr.m_num = 0

