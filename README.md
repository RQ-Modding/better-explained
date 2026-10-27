# better-explained

Appends a compact status line under skill hover (status + battle). Showcase: Copandon **Fortune** (skill **448**).

Example:

```text
Can't Crit / Can't Stun / Can't Poison
Ignores accuracy
```

Normal melee (e.g. Melee Attack 1 / **100**):

```text
Can Crit / Can Stun / Can't Poison
```

## Inference (Magnum combat)

| Tag | Rule |
| --- | --- |
| **Crit** | `倍率 > 150` or skill **120** → Can't Crit; else Can Crit (`クリティカル計算`) |
| **Stun** | Physical (`行動種類==1`) except **120 / 448 / 152** → Can Stun (`衝撃計算`). Also `機能==59`, or ids **149 / 183 / 422 / 507**. Else Can't Stun |
| **Poison** | Skill ids with rates in `毒計算` (**390, 404, 424, 443, 539, 560–562, 590**) or special **433 / 545** → Can Poison. **120** forced off. Weapon/passive poison not attributed to the skill |
| **Accuracy** | Second short line `Ignores accuracy` when `機能` is **56** or **79** (hit% forced 100 before absolute-miss) |

## Needs

1. Moru's fork (`RQ_modding_xsystem4`, `-Dmodloader=true`) with `rq.skill.get` fields `koudou` / `kouka`
2. `rqmod` apply into a work copy (`rqmod\apply.ps1`)

Local-only git. No remote.

## API

```lua
rq.skill.install()
rq.skill.on_describe(function(skillNo, baseText) ... end)
local s = rq.skill.get(448)
-- {id, name, kinou, bairitsu, target, koudou, kouka, desc1}
```

## Test

Hover **Fortune (448)** → trio Can't Crit/Stun/Poison + `Ignores accuracy`. Hover **Melee Attack 1 (100)** → `Can Crit / Can Stun / Can't Poison` only.
