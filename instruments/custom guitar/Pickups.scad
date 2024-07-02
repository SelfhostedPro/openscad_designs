include <BOSL2/joiners.scad>
include <BOSL2/std.scad>

tol = 0.05;

module cable_holes(top = false, right = false, bottom = false, left = false)
{
    if (top)
        translate([ 23, 16.5, -3.9 ]) hull()
        {
            rotate([ 90, 90, 0 ]) cylinder(h = 15, d = 8, center = true);
            translate([ 12, 0, 0 ]) rotate([ 90, 90, 0 ]) cylinder(h = 15, d = 8, center = true);
        }
    if (right)
        translate([ 45, -16, -3.9 ]) hull()
        {
            rotate([ 0, 90, 0 ]) cylinder(h = 20, d = 8, center = true);
            translate([ 0, 12, 0 ]) rotate([ 0, 90, 0 ]) cylinder(h = 20, d = 8, center = true);
        }
    if (bottom)
        translate([ 35, -16.5, -3.9 ]) hull()
        {
            rotate([ 90, 90, 0 ]) cylinder(h = 15, d = 8, center = true);
            translate([ -12, 0, 0 ]) rotate([ 90, 90, 0 ]) cylinder(h = 15, d = 8, center = true);
        }
}

module single(tol = tol)
{
    translate([ 0.5, 0, 2 ]) cuboid([ 70.5 + tol, 22 + tol, 20.8 ], rounding = 3,
                                    edges = [ FRONT + RIGHT, FRONT + LEFT, BACK + RIGHT, BACK + LEFT ]);
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
    translate([ -38.5, -0.2, -10 ]) cylinder(h = 5, d = 5, $fn = 32, center = true);
    translate([ 39.7, -0.2, -10 ]) cylinder(h = 5, d = 5, $fn = 32, center = true);
}

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
    translate([ -38.5, -0.2, -10 ]) cylinder(h = 5, d = 5, $fn = 32, center = true);
    translate([ 39.7, -0.2, -10 ]) cylinder(h = 5, d = 5, $fn = 32, center = true);
}

module pickup_slider(type = "humbucker", tol = tol, cut = false, top = false, right = false, bottom = false,
                     left = false)
{
    difference()
    {
        cuboid([ 95, cut == true ? 43 : 42, 20 ], rounding = 2,
               edges = [ BOTTOM + RIGHT, BOTTOM + FRONT, BOTTOM + BACK ], $fn = 20)
        {
            attach(BOTTOM, BOTTOM)
            {
                // Dovetail for the slide to align easily
                translate([ 7.5, 0, 0 ]) rotate([ 0, 0, 90 ])
                    dovetail("female", h = 5, w = 30, slide = 80, angle = -30, round = true, radius = 0.25, $fn = 32);
                // Dovetail at the end that holds the pickup in place
                translate([ -80 / 2 + 1, 0, -0.1 ]) rotate([ 0, 0, -90 ])
                    dovetail(cut == true ? "female" : "male", w = cut == true ? 20 : 19.6, h = 5, slide = 14,
                             taper = -1, $slop = tol, radius = 0.25, round = true, $fn = 32);
                // Add divits into the cuts in order to snap into place better and hold a bit better
                if (!cut)
                {
                    translate([ -20, 0, 0 ]) cube([ 10, 33, 3.7 ]);
                    translate([ 20, 0, 0 ]) cube([ 10, 33, 3.7 ]);
                }
                else
                {
                    translate([ 7.5, 0, 0 ]) cube([ 80, 33, 3.5 ]);
                }
            }
        }
        if (!cut)
        {
            if (type == "humbucker")
            {
                translate([ 2.5, 0, 0 ]) humbucker(tol = tol, cut = cut);
                cable_holes(top, right, bottom, left);
            }
            else if (type == "single")
            {
                translate([ 2.5, 0, 0 ]) single(tol = tol);
                cable_holes(top, right, bottom, left);
            }
        }
    }
    if (cut == true)
        cable_holes(top, right, bottom, left);
}
difference()
{
   //pickup_slider(tol = 0.05, cut = false, top = true, right = true);
    // translate([0,0,10])
    // #cube([100,100,37], center=true);
}
translate([ 100, 0, 0 ]) pickup_slider("single", tol = 0.05, cut = false, top = true, bottom = true);
//translate([ -100, 0, 0 ]) single(tol = 0.05);
// humbucker(0.05, false, true);