include <BOSL2/joiners.scad>
include <BOSL2/std.scad>
include <Round-Anything/polyround.scad>

$fn = 100;

tolerance = 0.3;

thickness = 5;

l = 152;
w = 100;
h = 40;

plate_offset = 1.5;

points = [
    // Top Left
    [ w / 2 - w / 4, l / 2 ],
    // Upper Left
    [ w / 2, l / 2 - l / 3.5 ],
    // Bottom Left
    [ w / 2 - w / 4, -l / 2 ],
    // Bottom Right
    [ -w / 2 - -w / 4, -l / 2 ],
    // Upper Right
    [ -w / 2, l / 2 - l / 3.5 ],
    // Top Right
    [ -w / 2 - -w / 4, l / 2 ]

];

module hook_shell(size = [ l, w, h ], plate_offset = plate_offset)
{
    linear_extrude(size.z / 2) polygon(points);
}

module hook(size = [ l, w, h ], cut = false)
{
    hook_points = [
        [ 0, 0, 0 ], // Bottom Base
        // [ h / 9, h / 6, 30 ], // Bottom Initial Curve
        [ size.z - thickness, size.z / 4, 5 ], // Bottom Tip
        [ size.z, size.z, 5 ], // Top Tip
        [ size.z - thickness, size.z, 5 ], // Top Inside
        [ size.z - thickness * 2, size.z / 3, 5 ], // Top Inside Bottom
        [ size.z / 15, size.z / 3, 5 ], // Mid Dip
        [ 0, size.z, 0 ], // Top Base
        // [ -size.z / 4, size.z - size.z / 1.1, 0 ], // Interior Bottom Outer
        [ -size.z / 7, size.z - size.z / 1.1, 2 ], // Interior Bottom Inner
        // [ -3, size.z / 6, 2 ], // Interior Inner Outer
        // [ 0, size.z / 6, 2 ] // Interior Inner Inner

    ];
    // difference()
    // {
    // }
    union()
    {
        linear_extrude(size.y / 10) polygon(polyRound(hook_points, fn = 100));
        difference()
        {

            translate([ -1, 14, 5 ]) rotate([ 0, cut ? 90 : -90, 0 ]) rotate([ cut ? 18 : -18, 0, 0 ]) dovetail(cut ? "female" : "male", w = cut ? size.y / 12 : (size.y / 12) - 0.35, round = true, slope = 4, radius = 0.5, h = 5, slide = size.z / 1.4, taper = -1);
            translate([ 5, 25, 5 ]) cuboid([ 10, 15, 10 ]);
        }
    }
}

module slide(size = [ 20, 30, 5 ], cut = false)
{
    dovetail(cut ? "female" : "male", round = true, radius = 1, w = cut ? size.x : size.x - 0.3, slide = cut ? size.y : size.y - 1, h = size.z, taper = 1) if (cut) attach(BOTTOM, TOP) cuboid([ size.x, size.y, 1.5 ]);
}

difference()
{
    hook_shell([ l, w, h ], plate_offset);
    translate([ -w / 10, -l / 2 + 5, h / 2 ])
        rotate([ 0, -90, 0 ])
            #hook([ l, w, h ], cut = true);

    translate([ w / 5, -l / 2 + 5, h / 2 ])
        rotate([ 0, -90, 0 ])
            hook([ l, w, h ], cut = true);
    translate([ 0, -l / 6, 1.5 ]) rotate([ 0, 180, 0 ]) slide([ w / 3, l / 1.5, h / 5.5 ], cut = true);
    // translate([ 0, -l / 4, 0.75 ]) cuboid([ 12.7, 92, 1.5 ]);
}

translate([ 100, -10, 0 ]) hook([ l, w, h ], cut = false);
translate([ 100, -60, 0 ]) hook([ l, w, h ]);
translate([ 110, 50, 0 ]) rotate([ 0, 0, 90 ]) slide([ w / 3, l / 1.5, h / 5.5 ]);