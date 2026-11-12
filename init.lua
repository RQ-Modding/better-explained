-- Better Explained: a line on a skill's hover text that says whether it can crit, stun or poison,
-- and whether it ignores accuracy.
-- API reference: https://rq-modding.github.io/rq-modding-docs/reference/
--
-- 1.1.0: the rules are the loader's (rq.combat.rules, loader 2.44.0), read at each hover: the
-- skill's data as it is then, the game's rules by skill number, and what other mods set with
-- rq.combat.set_rules. The mod keeps no list of its own, so a mod that changes a skill's rule is
-- shown right without knowing this one.

local function tag(v, yes, no)
  if v == "sometimes" then return yes .. " (sometimes)" end
  if v then return yes end
  return no
end

local function poison_tag(v)
  if v == "own" then return "Can Poison" end
  if v == "coat" then return "Can Poison (coat)" end
  if v == "sometimes" then return "Can Poison (sometimes)" end
  return "Can't Poison"
end

-- The line shows on a skill that rolls one of the three in a fight: physical attacks and the few
-- special skills that stun or poison. Magic, support skills and abilities get none.
local function lines_of(no)
  local r = rq.combat.rules(no)
  if not r then return {} end
  local lines = {}
  if r.crit ~= false or r.stun ~= false or r.poison ~= false then
    lines[#lines + 1] = table.concat({
      tag(r.crit, "Can Crit", "Can't Crit"),
      tag(r.stun, "Can Stun", "Can't Stun"),
      poison_tag(r.poison),
    }, " / ")
  end
  if r.accuracy == "ignores" then
    lines[#lines + 1] = "Ignores accuracy"
  end
  return lines
end

rq.skill.on_describe(function(no, text)
  local lines = lines_of(no)
  if #lines == 0 then return text end
  local extra = table.concat(lines, "\n")
  if not text or text == "" then return extra end
  return text .. "\n" .. extra
end)

rq.log("better-explained: the hover's line from rq.combat.rules")

-- For tests and other mods (rq.mod.get("better-explained")): the lines a skill's hover gets.
return {
  lines = lines_of,
}
