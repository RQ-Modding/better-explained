-- Compact Crit/Stun/Poison on skills that actually roll those in combat.
-- Omit on yellow abilities / blue support / white passives that don't hit.
-- Poison: physical 毒計算 can use skill rates OR Poison Effect (264) coat OR weapon 118.

-- 衝撃計算 early-out
local NO_STUN = {
  [120] = true, -- Assassinate
  [448] = true, -- Fortune
  [152] = true, -- Leazas' Lightning Dragon
}

-- Stun outside physical 衝撃計算
local EXTRA_STUN = {
  [149] = true,
  [183] = true,
  [422] = true,
  [507] = true,
}

-- Skill-id rates inside 毒計算 (+ 特殊 433/545)
local SKILL_POISON = {
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
  if skillNo == 120 then
    return false
  end
  return not (bairitsu and bairitsu > 150)
end

local function can_stun(skillNo, koudou, kinou)
  if NO_STUN[skillNo] then
    return false
  end
  if koudou == 1 then
    return true
  end
  if kinou == 59 then
    return true
  end
  return EXTRA_STUN[skillNo] == true
end

--[[
  毒計算 (from Ｔ物理攻撃行動 — Fortune 448 included; no 448 skip):
    skill-id rates → else weapon 118 → else if bb==0: ＣＳ有無／ランク別効果(iic, 264)
    iis==120 forces bb=0
  Returns: false | "skill" | "coat"
  Hover is skill-only, so coat means eligible if weapon 118 / Poison Effect 264.
]]
local function poison_kind(skillNo, koudou)
  if skillNo == 120 then
    return false
  end
  if SKILL_POISON[skillNo] then
    return "skill"
  end
  if koudou == 1 then
    return "coat" -- path runs 毒計算; coat/weapon can fill bb (incl. Fortune 448)
  end
  return false
end

--[[
  Show the trio only when this skill participates in hit/crit/stun/poison math.
  行動種類: 1 physical, 2 magic, 3 special, 4 support, 0 ability (yellow/white).
  Abilities (Poison Effect 264, Counter 259, …) and support blues: omit.
]]
local function show_trio(skillNo, koudou, kinou)
  if koudou == 1 then
    return true -- red physical (Ｔ物理攻撃行動)
  end
  if EXTRA_STUN[skillNo] or kinou == 59 then
    return true
  end
  if SKILL_POISON[skillNo] then
    return true
  end
  return false
end

local function tag(ok, yes, no)
  if ok then
    return yes
  end
  return no
end

local function poison_tag(kind)
  if kind == "skill" then
    return "Can Poison"
  end
  if kind == "coat" then
    return "Can Poison (coat)"
  end
  return "Can't Poison"
end

local function trio_line(skillNo, info)
  local bairitsu = info and info.bairitsu or 0
  local kinou = info and info.kinou or 0
  local koudou = info and info.koudou or 0
  return table.concat({
    tag(can_crit(skillNo, bairitsu), "Can Crit", "Can't Crit"),
    tag(can_stun(skillNo, koudou, kinou), "Can Stun", "Can't Stun"),
    poison_tag(poison_kind(skillNo, koudou)),
  }, " / ")
end

local function ignores_accuracy(kinou)
  return kinou == 56 or kinou == 79
end

rq.log("better-explained: trio on hit skills; poison = skill rate or (coat)")

if not rq.skill.install() then
  error("better-explained: rq.skill.install failed (see mods/rqmod.log)")
end

rq.skill.on_describe(function(skillNo, baseText)
  local info = rq.skill.get(skillNo)
  local kinou = info and info.kinou or 0
  local koudou = info and info.koudou or 0
  local lines = {}

  if show_trio(skillNo, koudou, kinou) then
    lines[#lines + 1] = trio_line(skillNo, info)
  end
  if ignores_accuracy(kinou) then
    lines[#lines + 1] = "Ignores accuracy"
  end

  if #lines == 0 then
    return baseText
  end

  if skillNo == 448 or skillNo == 121 or skillNo == 264 then
    rq.log(string.format("hover %d: %s", skillNo, table.concat(lines, " | ")))
  end

  local extra = table.concat(lines, "\n")
  if not baseText or baseText == "" then
    return extra
  end
  return baseText .. "\n" .. extra
end)
