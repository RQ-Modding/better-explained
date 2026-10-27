# better-explained

Appends skill-hover lines when a skill cannot crit or ignores ACC/EVA. Showcase: Copandon **Fortune** (skill **448**).

| Rule | Hover line |
| --- | --- |
| `倍率` (bairitsu) **> 150** | `Cannot critical.` |
| `機能` (kinou) **56** or **79** | `Ignores accuracy (cannot miss normally)` |

Wording avoids “Never misses” — absolute-miss can still zero the hit afterward.

## Needs

1. Moru's fork (`RQ_modding_xsystem4`, `-Dmodloader=true`) — not stock xsystem4 1.0.0
2. `rqmod` apply into a work copy (`rqmod\apply.ps1`)

Local-only git. No remote.

## API

```lua
rq.skill.install()
rq.skill.on_describe(function(skillNo, baseText)
  return baseText -- UTF-8; engine converts SJIS
end)
local s = rq.skill.get(448) -- {id, name, kinou, bairitsu, target, desc1}
```

## Test

Battle or status hover on **Fortune** → base text plus both tag lines. Spot-check another high-`倍率` skill (crit line only) and a normal skill (no extra lines). Console: `[better-explained]`.
