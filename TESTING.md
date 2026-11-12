# Testing Better Explained

For people and agents who test the mod in the game. Check `logs\rqmod.log` for
`Loading better-explained` first; without it, the hover has no extra line.

## What it adds

No buttons and no `rq.agent.control` ids. Do not invent controls for it. It only adds text to skill
hovers, from `rq.combat.rules(skill)` (loader 2.44.0). `rq.mod.get("better-explained").lines(skill)`
returns the lines a skill's hover gets.

## How to check it

1. Hover a skill: on a status page, in the skill shop (`offer-N` rows) or in a fight, and read the
   hover text on screen.
2. **Melee Attack 1** (100) ends with `Can Crit / Can Stun / Can Poison (coat)`.
3. **Fortune** (448, Copandon Dot) ends with `Can Crit (sometimes) / Can't Stun / Can Poison (coat)`
   and `Ignores accuracy`. With Copandon Dot QoL installed it says `Can Crit / Can Stun` instead.
4. **Assassinate** (120) ends with `Can Crit (sometimes) / Can't Stun / Can't Poison`.
5. **Poison Effect** (264) and **Counter** (259) have no extra line.
6. `rq.combat.set_rules(152, { stun = true })` changes 152's hover to `Can Stun` at once;
   `{ stun = "game" }` puts it back.

## Test Lab

`agent-lab.ps1 run spellblade` checks the Fortune hover with this mod and Copandon Dot QoL;
`run rules` checks the lines of Melee Attack, Assassinate and Poison Effect, and a rule set and put
back on 152.
