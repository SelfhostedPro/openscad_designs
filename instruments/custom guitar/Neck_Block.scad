include <BOSL2/joiners.scad>
include <BOSL2/std.scad>
include <Round-Anything/polyround.scad>

module neck_holes(height, tol)
{
    translate([ -16.2, -21.8, 0 ]) cylinder(h = height + 3, d = 5 + tol, center = true, $fn = 32);
    translate([ 18.2, -21.8, 0 ]) cylinder(h = height + 3, d = 5 + tol, center = true, $fn = 32);
    translate([ 18.2, 22.2, 0 ]) cylinder(h = height + 1.5, d = 5 + tol, center = true, $fn = 32);
    translate([ -16.2, 22.2, 0 ]) cylinder(h = height + 1.5, d = 5 + tol, center = true, $fn = 32);
    translate([ 1, 0.2, 0 ]) cylinder(h = height + 1.5, d = 5 + tol, center = true, $fn = 32);
}

module neck_connection(size = [ 51, 61, 45 ], cut, tol)
{
    neck_tol = tol * 5;

    upper_size = [
        cut == true ? size.x - 6 + neck_tol : size.x - 6 - neck_tol,
        cut == true ? size.y - 6 + neck_tol : size.y - 6 - neck_tol, cut == true ? size.z/2.5 : size.z/3 - 2
    ];

    lower_size = [
        cut == true ? size.x + neck_tol : size.x - neck_tol,
        cut == true ? size.y + neck_tol : size.y - neck_tol, cut == true ? size.z/2 : size.z/3
    ];

    difference()
    {
        translate([ 0, 0, cut == true ? 2.5 : 0 ]) union()
        {
            // Thinner Top Section
            cuboid(upper_size, rounding = 2,
                   edges =
                       [
                           TOP + FRONT, TOP + RIGHT, TOP + LEFT, TOP + BACK, FRONT + RIGHT, FRONT + LEFT, BACK + RIGHT,
                           BACK +
                           LEFT
                       ],
                   $fn = 32)
            {
                attach(BOTTOM, BOTTOM, inside = true) translate([ 0, 0, cut == true ? -size.z/4 - 3: -size.z/4 ])
                    // Thicker Lower Section
                    cuboid(lower_size, rounding = 2, edges = [ FRONT + RIGHT, FRONT + LEFT, BACK + RIGHT, BACK + LEFT ],
                           $fn = 32)
                {
                    // position(FRONT)
                    attach(FRONT, overlap = cut == true ? 0 : 0.2) rotate([ cut == true ? 180 : 0, 0, 0 ])
                        dovetail(cut == true ? "female" : "male", angle = 0, w = 30, h = 3,
                                 taper = cut == true ? -1 : 1, slide = lower_size.z,
                                 $slop = cut == true ? tol : tol + 0.02, radius = 0.5, round = true, $fn = 32);
                    attach(BACK, overlap = cut == true ? 0 : 0.2) rotate([ cut == true ? 180 : 0, 0, 0 ])
                        dovetail(cut == true ? "female" : "male", angle = 0, w = 30, h = 3,
                                 taper = cut == true ? -1 : 1, slide = lower_size.z,
                                 $slop = cut == true ? tol : tol + 0.02, radius = 0.5, round = true, $fn = 32);
                }
            }
        }
    if (!cut == true)
    neck_holes(height = size.z + 5, tol = tol);
    }
}

neck_connection(cut = false, tol = 0.05);