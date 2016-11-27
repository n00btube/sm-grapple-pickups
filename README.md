# Grapple Pickups

Now Samus can grab items by shooting them with the Grapple Beam.
Why not?

# Description

In the original game, item pickups are inert for all projectiles.

`grapple-pickups` patches the block collision code to make grapple count as picking them
up.  Uses some free space in bank $94.

# Known Issue

Picking up a suit with the Grapple Beam will leave the electric sounds on
throughout the suit effect, until Samus leaves elevator pose.

This can happen in the vanilla game:
fire the grapple beam just before picking up Gravity Suit.
If done late enough, it doesn’t hit the door, and the Gravity Suit is _electric._

I’ve tracked a root cause of the problem, but I haven’t decided what to do about it.
And it’s tripled the length of time I’ve spent on this.
So, here’s v1, no grapple fix.

(Root cause: the suit flash code sets $C856—stop grappling—as the grapple beam per-frame code pointer.
But with Samus in elevator pose, actually calling that code is skipped.
$C856 never gets to clear grapple state and change the pointer to $C4F0, beam off.
Which happens to also be the only value that prevents re-starting the sound.)


# Credits

This patch could not exist without docs by Kejardon, pjboy, Scyzer,
and the rest of [MetConst](http://metroidconstruction.com).

# Author

Adamf.

# License

MIT.
