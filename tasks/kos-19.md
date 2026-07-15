# KOS-19 — Patch cable physics: the cable is too light, it floats

**Status:** Done (v5.7, PR #7)

## Description

The patch cables (KOS-17) behaved like a feather — they fell slowly and floated in the air instead of swinging and settling like a heavy rubber cable. On top of that, dragging a cable across the keyboard triggered notes (mouseenter with the button held).

## Solution

- Gravity 1600 → 3200 px/s² — fast, heavy fall.
- Damping 0.955 → 0.98 per substep — the cable has inertia, swings once and settles quickly.
- Constraint solver 3 → 4 iterations so the rope doesn't stretch like a rubber band under the stronger gravity.
- `window.isCableDrag()` exposed from the patchbay + a guard in `setupKey()` — keys ignore the mouse while a cable is being dragged.
