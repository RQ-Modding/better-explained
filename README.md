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
- **(sometimes)** means the game's rule has exceptions: **Can Crit (sometimes)** is a skill whose
  critical chance the game sets to 0 (a damage multiplier above 150, or Assassinate). The game
  still raises it in two cases: an attacker with **Low Blow** against a man or a Guy Monster, on
  half the attacks, and an enemy's attack while Kojika Yamanaka is in the party.
- The line appears on physical attacks and on the few special skills that stun or poison. Magic,
  support skills and abilities (yellow and white skills such as Counter or Poison Effect) get no
  line, since they do not roll a hit of their own.

Examples: **Melee Attack** says Can Crit / Can Stun / Can Poison (coat). Copandon's **Fortune** says
Can Crit (sometimes) / Can't Stun / Can Poison (coat) and Ignores accuracy (with Copandon Dot QoL it
says Can Crit / Can Stun).

## Keys and settings

None.

## Saves

Nothing. It only changes text.

## Works with

The line is read at each hover from the loader's rules (`rq.combat.rules`), so a mod that changes
what a skill can do with `rq.combat.set_rules`, as Copandon Dot QoL does for Fortune, is shown right
without anything more. A skill changed with `rq.skill.patch` is shown as it is then. Any other mod
that changes skill hover text works beside it; load order decides whose text comes last.

## Install

Needs [RQ MOD](https://github.com/RQ-Modding/RQ-Mod) with loader **2.44.0** or newer. Extract the
release zip into the game's `mods` folder, so that you have `mods/better-explained/mod.json`.

## How it works

The rules are the loader's (`rq.combat.rules`, loader 2.44.0), which follow the game's own combat
code (`戦闘関係.jaf`), and what mods set:

| Tag | Rule |
| --- | --- |
| Crit | Physical attacks can (`クリティカル計算`). Sometimes when the damage multiplier is above 150, or for Assassinate (120): the game sets the chance to 0, then Low Blow (549) adds 50 on half the rolls against a man or race 4, and character 91 (Kojika) in the party adds 30 to an enemy's attack. |
| Stun | Physical attacks can, except Assassinate (120), Fortune (448) and Leazas' Lightning Dragon (152) (`衝撃計算`). Also skills with function 59, and skills 149, 183, 422 and 507. |
| Poison | Skills with their own poison rate in `毒計算` say Can Poison. Other physical attacks except Assassinate say Can Poison (coat): `毒計算` still runs, and weapon 118 or Poison Effect (264) fills the rate. |
| Accuracy | Ignores accuracy for function 56 or 79. |

## License

MIT, see [LICENSE](LICENSE).
