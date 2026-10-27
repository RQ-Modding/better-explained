-- Compact skill-hover tags: Crit / Stun / Poison (+ short accuracy line).
-- Policy from Magnum combat (衝撃計算 / 毒計算 / クリティカル計算). C only wraps.

-- 衝撃計算 early-out: these physical skills never roll stun.
local NO_STUN = {
  [120] = true, -- Assassinate
  [448] = true, -- Fortune
  [152] = true, -- Leazas' Lightning Dragon
}

-- Extra stun outside physical 衝撃計算 (特殊 / one magic).
local EXTRA_STUN = {
  [149] = true, -- abuse special
  [183] = true, -- magic conditional stun
  [422] = true, -- special
  [507] = true, -- special
}

-- 毒計算 skill rates + 特殊 hardcodes (433, 545). Not weapon/passive 264.
local POISON = {
  [390] = true,
  [404] = true,
  [424] = true,
  [443] = true,
  [539] = true,
  [560] = true,
  [561] = true,
  [562] = true,
  [590] = true,
  [433] = true,
  [545] = true,
}

local function can_crit(skillNo, bairitsu)
  -- クリティカル計算: 倍率 > 150 or id 120 forces rate 0.
  if skillNo == 120 then
    return false
  end
  return not (bairitsu and bairitsu > 150)
end

local function can_stun(skillNo, koudou, kinou)
  if NO_STUN[skillNo] then
    return false
  end
  -- Physical path runs 衝撃計算 (character 衝撃率; 機能 59 boosts).
  if koudou == 1 then
    return true
  end
  -- 特殊: 機能 59 guarantees stun (e.g. Stunner 432).
  if kinou == 59 then
    return true
  end
  return EXTRA_STUN[skillNo] == true
end

local function can_poison(skillNo)
  -- 毒計算 forces bb=0 for Assassinate.
  if skillNo == 120 then
    return false
  end
  -- Skill-inherent rates only (武器 118 / passive 264 are equipment/character).
  return POISON[skillNo] == true
end

local function tag(ok, yes, no)
  if ok then
    return yes
  end
  return no
end

local function trio_line(skillNo, info)
  local bairitsu = info and info.bairitsu or 0
  local kinou = info and info.kinou or 0
  local koudou = info and info.koudou or 0
  return table.concat({
    tag(can_crit(skillNo, bairitsu), "Can Crit", "Can't Crit"),
    tag(can_stun(skillNo, koudou, kinou), "Can Stun", "Can't Stun"),
    tag(can_poison(skillNo), "Can Poison", "Can't Poison"),
  }, " / ")
end

local function ignores_accuracy(kinou)
  return kinou == 56 or kinou == 79
end

rq.log("better-explained: compact Crit/Stun/Poison (+ Ignores accuracy)")

if not rq.skill.install() then
  error("better-explained: rq.skill.install failed (see mods/rqmod.log)")
end

rq.skill.on_describe(function(skillNo, baseText)
  local info = rq.skill.get(skillNo)
  local lines = { trio_line(skillNo, info) }
  local kinou = info and info.kinou or 0

  if ignores_accuracy(kinou) then
    lines[#lines + 1] = "Ignores accuracy"
  end

  if skillNo == 448 then
    rq.log("Fortune hover: " .. table.concat(lines, " | "))
  end

  local extra = table.concat(lines, "\n")
  if not baseText or baseText == "" then
    return extra
  end
  return baseText .. "\n" .. extra
end)
