# Testing Better Explained

For people and agents who test the mod in the game. Check `logs\rqmod.log` for
`Loading better-explained` first; without it, the hover has no extra line.

## What it adds

No buttons and no `rq.agent.control` ids. Do not invent controls for it. It only adds text to skill
hovers.

## How to check it

1. Hover a skill: on a status page, in the skill shop (`offer-N` rows) or in a fight, and read the
   hover text on screen.
2. **Melee Attack 1** (100) ends with `Can Crit / Can Stun / Can Poison (coat)`.
3. **Fortune** (448, Copandon Dot) ends with `Can't Crit / Can't Stun / Can Poison (coat)` and
   `Ignores accuracy`. With Copandon Dot QoL installed it says `Can Crit / Can Stun` instead.
4. **Poison Effect** (264) and **Counter** (259) have no extra line.
5. The log prints `hover 448: ...`, `hover 121: ...` or `hover 264: ...` when one of those three is
   hovered.

## Test Lab

`agent-lab.ps1 run spellblade` checks the Fortune hover with this mod and Copandon Dot QoL.
