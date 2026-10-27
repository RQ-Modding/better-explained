-- Append skill-hover lines for cannot-crit / accuracy-ignore.
-- Showcase: Copandon Fortune (skill 448). Policy lives here, not in C.

local CRIT_LINE = "Cannot critical."
local ACC_LINE = "Ignores accuracy (cannot miss normally)"

rq.log("better-explained: skill hover tags (Fortune 448 + generic rules)")

if not rq.skill.install() then
  error("better-explained: rq.skill.install failed (see mods/rqmod.log)")
end

rq.skill.on_describe(function(skillNo, baseText)
  local info = rq.skill.get(skillNo)
  local lines = {}
  local bairitsu = info and info.bairitsu or 0
  local kinou = info and info.kinou or 0

  -- Crit rate forced to 0 when 倍率 > 150 (combat クリティカル計算).
  if bairitsu > 150 then
    lines[#lines + 1] = CRIT_LINE
  end

  -- 機能 56 / 79: hit% forced to 100 before absolute-miss checks.
  if kinou == 56 or kinou == 79 then
    lines[#lines + 1] = ACC_LINE
  end

  -- Fortune (448) is covered by the generic rules above; keep id for clarity/logs.
  if skillNo == 448 and #lines > 0 then
    rq.log(string.format("Fortune hover tags (%d lines)", #lines))
  end

  if #lines == 0 then
    return baseText
  end
  if not baseText or baseText == "" then
    return table.concat(lines, "\n")
  end
  return baseText .. "\n" .. table.concat(lines, "\n")
end)
