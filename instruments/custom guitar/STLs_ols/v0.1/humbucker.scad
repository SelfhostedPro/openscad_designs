















// External Libraries
include <BOSL2/joiners.scad>
include <BOSL2/std.scad>

tol = 0.05;

module humbucker(tol = tol, cut = false, holes = true)
{
    translate([ 0.5, 0, 2 ]) cuboid([ 70.5 + tol, 40 + tol, 20.8 ], rounding = 3,
                                    edges = [ FRONT + RIGHT, FRONT + LEFT, BACK + RIGHT, BACK + LEFT ], $fn = 32);
    translate([ 0.5, 0, 8.1 ]) cuboid([ 87.6 + tol, 30 + tol, 4.1 ], rounding = 3,
                                      edges = [ FRONT + RIGHT, FRONT + LEFT, BACK + RIGHT, BACK + LEFT ], $fn = 32);
    // upper holes
    translate([ -39.9, 11.3, 1.2 ]) cylinder(h = 5, d = 4, $fn = 32);
    translate([ -39.9, -11.7, 1.2 ]) cylinder(h = 5, d = 4, $fn = 32);
    translate([ 41.1, 11.3, 1.2 ]) cylinder(h = 5, d = 4, $fn = 32);
    translate([ 41.1, -11.7, 1.2 ]) cylinder(h = 5, d = 4, $fn = 32);

    translate([ 0.5, -0.25, 1 ]) cuboid([ 87.6 + tol, 16 + tol, 20.8 ], rounding = 7,
                                        edges = [ FRONT + RIGHT, FRONT + LEFT, BACK + RIGHT, BACK + LEFT ], $fn = 32);
    // Lower Holes
    translate([ -38.5, -0.2, -10 ]) cylinder(h = 3, d = 5, $fn = 32, center = true);
    translate([ 39.7, -0.2, -10 ]) cylinder(h = 3, d = 5, $fn = 32, center = true);

    // Cable Holes
    if (holes == true)
    {
        translate([ 18, 20, -4.5 ]) hull()
        {
            rotate([ 90, 90, 0 ]) cylinder(h = 10, d = 8, center = true);
            translate([ 12, 0, 0 ]) rotate([ 90, 90, 0 ]) cylinder(h = 10, d = 8, center = true);
        }
        // Cable Holes
        translate([ 40, -16, -4.5 ]) hull()
        {
            rotate([ 0, 90, 0 ]) cylinder(h = 15, d = 8, center = true);
            translate([ 0, 12, 0 ]) rotate([ 0, 90, 0 ]) cylinder(h = 15, d = 8, center = true);
        }
    }
}

module humbucker_cradle(cut, holes, tol)
{
    if (cut == true)
    {
        union()
        {
            cube([ 90, 45 - tol, 20 ], center = true);
            translate([ -6.5, 0, -11 ]) cube([ 77, 33, 5 ], center = true);
            translate([ -6.5, 0, -10 ]) rotate([ 0, 0, 90 ]) dovetail(
                "female", w = 30, h = 5, slide = 86, $slop = tol, angle = -30, radius = 0.25, round = true, $fn = 32);
            translate([ 36.5, 0, -10 ]) rotate([ 0, 0, 90 ]) dovetail(
                "female", w = 20, h = 5, slide = 12, taper = -1, $slop = tol, radius = 0.25, round = true, $fn = 32);
            // translate([ 38, 0, -12 ]) cube([ 10 + 0.2, 8 + 0.2, 5 ], center = true);

            // translate([ 38, 5, -12.5 ]) cuboid([ 10, 25, 5 ], rounding = 3, edges = [RIGHT + BOTTOM], $fn = 32);
        }
    }
    else
    {
        difference()
        {
            union()
            {
                cube([ 90, 45 - tol, 20 ], center = true);
                translate([ 0, 0, -10 ]) cube([ 10, 33, 5 ], center = true);
                translate([ -6, 0, -9 ]) rotate([ 0, 180, 90 ]) dovetail(
                    "male", w = 30, h = 5, slide = 75, angle = -30, $slop = tol, radius = 0.25, round = true, $fn = 32);
                translate([ 36.5, 0, -9 ]) rotate([ 0, 180, 90 ])
                    dovetail("male", w = 19.4, h = 5, slide = 12, taper = -1, $slop = tol, radius = 0.25, round = true,
                             $fn = 32);
            }
            translate([ 0.5, 0, 2 ])
                cuboid([ 70.5 + tol, 40 + tol, 20.8 ], rounding = 3,
                       edges = [ FRONT + RIGHT, FRONT + LEFT, BACK + RIGHT, BACK + LEFT ], $fn = 32);
            translate([ 0.5, 0, 8.1 ])
                cuboid([ 87.6 + tol, 30 + tol, 4.1 ], rounding = 3,
                       edges = [ FRONT + RIGHT, FRONT + LEFT, BACK + RIGHT, BACK + LEFT ], $fn = 32);
            // upper holes
            translate([ -39.9, 11.3, 1.2 ]) cylinder(h = 5, d = 4, $fn = 32);
            translate([ -39.9, -11.7, 1.2 ]) cylinder(h = 5, d = 4, $fn = 32);
            translate([ 41.1, 11.3, 1.2 ]) cylinder(h = 5, d = 4, $fn = 32);
            translate([ 41.1, -11.7, 1.2 ]) cylinder(h = 5, d = 4, $fn = 32);

            translate([ 0.5, -0.25, 1 ])
                cuboid([ 87.6 + tol, 16 + tol, 20.8 ], rounding = 7,
                       edges = [ FRONT + RIGHT, FRONT + LEFT, BACK + RIGHT, BACK + LEFT ], $fn = 32);
            // Lower Holes
            translate([ -38.5, -0.2, -10 ]) cylinder(h = 3, d = 5, $fn = 32, center = true);
            translate([ 39.7, -0.2, -10 ]) cylinder(h = 3, d = 5, $fn = 32, center = true);

            // Cable Holes
            if (holes == true)
            {
                translate([ 18, 20, -4.5 ]) hull()
                {
                    rotate([ 90, 90, 0 ]) cylinder(h = 10, d = 8, center = true);
                    translate([ 12, 0, 0 ]) rotate([ 90, 90, 0 ]) cylinder(h = 10, d = 8, center = true);
                }
                // Cable Holes
                translate([ 40, -16, -4.5 ]) hull()
                {
                    rotate([ 0, 90, 0 ]) cylinder(h = 15, d = 8, center = true);
                    translate([ 0, 12, 0 ]) rotate([ 0, 90, 0 ]) cylinder(h = 15, d = 8, center = true);
                }
            }
        }
    }
}
translate([ 100, 0, 4 ]) humbucker(cut = false, holes = true, tol = 0.05);

// translate([-100,0,0])
// #humbucker(cut = true, holes = true, tol = 0.05);
union()
{
    translate([ 0, 0, -8.5 ]) cube([ 90, 45 - tol, 3 ], center = true);
    translate([ 0, 0, -10 ]) cube([ 10, 33.5, 5 ], center = true);
    translate([ -30, 0, -10 ]) cube([ 10, 33.5, 5 ], center = true);
    translate([ -6, 0, -9 ]) rotate([ 0, 180, 90 ])
        dovetail("male", w = 30, h = 5, slide = 75, angle = -30, $slop = tol, radius = 0.25, round = true, $fn = 32);
    translate([ 36.5, 0, -9 ]) rotate([ 0, 180, 90 ])
        dovetail("male", w = 19.75, h = 5, slide = 12, taper = -1, $slop = tol, radius = 0.25, round = true, $fn = 32);
    // translate([38,0,-12]) cube([10,20,5], center=true);
}