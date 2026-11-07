# Better Explained

Adds a short line to a skill's hover text that says whether the skill can land a critical hit, stun
or poison, and whether it ignores accuracy.

## What it changes

Under the hover text of a skill that rolls those things in a fight, one line such as:

```text
Can Crit / Can Stun / Can Poison (coat)
```

and, for a skill that always hits:

```text
Ignores accuracy
```

- **Can Poison** means the skill has its own poison chance. **Can Poison (coat)** means it poisons
  only when the attacker's weapon or **Poison Effect** supplies the poison, as for most physical
  attacks.
- The line appears on physical attacks and on the few special skills that stun or poison. Magic,
  support skills and abilities (yellow and white skills such as Counter or Poison Effect) get no
  line, since they do not roll a hit of their own.

Examples: **Melee Attack** says Can Crit / Can Stun / Can Poison (coat). Copandon's **Fortune** says
Can't Crit / Can't Stun / Can Poison (coat) and Ignores accuracy (with Copandon Dot QoL it says Can
Crit / Can Stun).

## Keys and settings

None.

## Saves

Nothing. It only changes text.

## Works with

Copandon Dot QoL loads after it and corrects the Fortune line. Any other mod that changes skill
hover text works beside it; load order decides whose text comes last.

## Install

Needs [RQ MOD](https://github.com/RQ-Modding/RQ-Mod) with loader **1.15.0** or newer. Extract the
release zip into the game's `mods` folder, so that you have `mods/better-explained/mod.json`.

## How it works

The rules follow the game's own combat code (`戦闘関係.jaf`):

| Tag | Rule |
| --- | --- |
| Crit | Can't when the damage multiplier is above 150, or for Assassinate (120). Else Can (`クリティカル計算`). |
| Stun | Physical attacks can, except Assassinate (120), Fortune (448) and Leazas' Lightning Dragon (152) (`衝撃計算`). Also skills with function 59, and skills 149, 183, 422 and 507. |
| Poison | Skills with their own poison rate in `毒計算` say Can Poison. Other physical attacks except Assassinate say Can Poison (coat): `毒計算` still runs, and weapon 118 or Poison Effect (264) fills the rate. |
| Accuracy | Ignores accuracy for function 56 or 79. |

## License

MIT, see [LICENSE](LICENSE).
