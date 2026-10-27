# better-explained

Appends a compact Crit/Stun/Poison line under skill hover **only** when the skill participates in those combat rolls. Showcase: Copandon **Fortune** (**448**), Suzume **Shuriken** (**121**).

## When the line appears

| Skill kind (`行動種類` / panel) | Trio line? |
| --- | --- |
| Physical attack (`行動種類==1`, red ~panel 100) | Yes |
| Magic / support / abilities (blue 101, yellow 102, white/Z) | **No**, unless a known stun/poison special |
| Specials with `機能==59` or hardcode stun/poison ids | Yes |

**Poison Effect (264)** and **Counter (259)** are yellow abilities → **no line** (they don't roll hit/crit themselves).

## Examples

**Shuriken (121)** — physical; stun via `衝撃計算` + `機能` 59; no skill-id poison rate:

```text
Can Crit / Can Stun / Can Poison (coat)
```

**Poison Effect (264)** — yellow ability (coats weapons; no own hit roll):

```text
(no Crit/Stun/Poison line)
```

**Fortune (448)** — physical path still calls `毒計算` (no 448 skip; only stun is skipped):

```text
Can't Crit / Can't Stun / Can Poison (coat)
Ignores accuracy
```

**Melee Attack 1 (100)**:

```text
Can Crit / Can Stun / Can Poison (coat)
```

**Efficient Action (245)** or other yellow/blue utility: no line.

## Inference (Magnum `戦闘関係.jaf`)

| Tag | Rule |
| --- | --- |
| **Crit** | `倍率 > 150` or id **120** → Can't; else Can (`クリティカル計算`, physical path) |
| **Stun** | Physical except **120 / 448 / 152** → Can (`衝撃計算`). Also `機能==59`, ids **149 / 183 / 422 / 507** |
| **Poison** | Inherent skill-id rates / specials → `Can Poison`. Other physical except **120** → `Can Poison (coat)` (`毒計算` still runs; weapon **118** or **264** fills `bb`). Fortune **448** is coat-eligible (called from `Ｔ物理攻撃行動`; no 448 poison skip). Assassinate **120** → `Can't Poison` |
| **Accuracy** | `Ignores accuracy` when `機能` **56** or **79** |

### Poison coat evidence

```text
毒計算:
  … skill-id rates …
  if weapon == 118 → bb = 100
  if bb == 0 → bb = ＣＳ有無／ランク別効果(attacker, 264, 0)  // Poison Effect
  if iis == 120 → bb = 0
```

Called from `Ｔ物理攻撃行動` only. Shuriken is not in the skill-id rate list, but with Poison Effect equipped the coat supplies `bb`. Saying `Can't Poison` on Shuriken was wrong.

## Needs

1. Fork with `rq.skill.get` (`koudou` / `kouka`)
2. `rqmod\apply.ps1` → Magnum Mods copy only

Local-only git. No remote.
