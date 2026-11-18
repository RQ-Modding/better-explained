# Changelog

Each section is a version of the mod, the `version` in `mod.json`. The release workflow copies the
section of a tagged version into the release notes.

## 1.1.0

- The line is read at each hover from the loader's `rq.combat.rules` (loader 2.44.0), not from
  lists in the mod: a mod that changes a skill's rule with `rq.combat.set_rules` is shown right, as
  Copandon Dot QoL's Fortune, and needs no change to this mod's text.
- **(sometimes)** where the game's rule has exceptions: a skill whose critical chance the game sets
  to 0 (a multiplier above 150, or Assassinate) says Can Crit (sometimes), since Low Blow (549)
  against a man, or Kojika in the party for an enemy's attack, can still raise it. It said Can't
  Crit.
- The hovers of Fortune, Shuriken and Poison Effect are no longer written to the log.
- For agents: `rq.mod.get("better-explained").lines(skill)` gives a skill's lines.
- Needs loader 2.44.0.

## 1.0.1

- The code names the game's characters, skills, items and states with `rq.ids` instead of
  numbers. Needs loader 1.15.0. No change in the game.

## 1.0.0

First version.

- A Crit / Stun / Poison line on the hover of skills that roll those in a fight, and an Ignores
  accuracy line.
- Can Poison (coat) for physical attacks that poison only through the weapon or Poison Effect.
- An error when the hook cannot be placed points at `logs/rqmod.log`.
