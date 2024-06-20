include <BOSL2/joiners.scad>
include <BOSL2/std.scad>
include <Round-Anything/polyround.scad>

tol = 0.05;

module spring_cutout()
{
    cube([ 27.5, 11, 25 ], center = true);
}
module screw_holes()
{
    // Screw Holes
    translate([ -24.4, -11.5, 25 / 2 + 1 ]) cylinder(h = 35, d = 3.5, center = true, $fn = 20);
    translate([ -24.4, 11, 25 / 2 + 1 ]) cylinder(h = 35, d = 3.5, center = true, $fn = 20);
    translate([ 25.6, -11.5, 25 / 2 + 1 ]) cylinder(h = 35, d = 3.5, center = true, $fn = 20);
    translate([ 25.6, 11, 25 / 2 + 1 ]) cylinder(h = 35, d = 3.5, center = true, $fn = 20);
}

module floyd_rose(cut, tol, size = [ 84, 34, 40 ])
{
    // translate([
    //     0, size.y / 2+1,
    //     // 70,
    //     size.z / 4 - 0.5
    // ])
    {
        // union()
        //     {
        difference()
        {
            cuboid([ size.x + 7.5, size.y + 2, size.z / 2 ]) // base
            {
                attach(TOP, BOTTOM)
                {
                    difference() // plate to screw bridge into
                    {
                        translate([ 0, -1, 0 ])
                            cuboid([ size.x, size.y, size.z / 2 - 5.5 ], rounding = 2, $fn = 32,
                                   edges = [ FRONT + LEFT, FRONT + RIGHT, BACK + LEFT, BACK + RIGHT ]);
                    }
                    // Edge that's level with front of guitar

                    difference() // edge around bridge
                    {
                        // translate([ 0, 0, 5 ])
                        cuboid([ size.x + 7.5, size.y + 2, size.z / 2 ]); // top
                        if (!cut == true)
                            translate([ 0, -2.5, 0 ])
                                cuboid([ size.x, size.y + 2.5, size.z / 2 + 9 ], rounding = 2, $fn = 32,
                                       edges = [ BACK + LEFT, BACK + RIGHT ]); // cutout plate for rest of the height
                    }
                }
                attach(BACK, BOTTOM) translate([
                    -size.x / 4 + 33, 0,
                    // 1.75,
                    0
                ]) rotate([ 0, 0, 90 ]) dovetail(cut == true ? "female" : "male", w = 15, h = 8, slide = 68, taper = 1.5,
                                                 $slop = 0.3 + tol, radius = 0.25, round = true, $fn = 32);
            }
            if (!cut == true)
            {
                translate([ 0, -0.5, 0 ]) screw_holes();
                translate([ 0.5, -size.y / 2 + 3.5, size.z / 2 ]) spring_cutout();
            }
            translate([ size.x / 2 - 8, size.y / 4 + 5, 0 ])
                cube([ 25, 13, size.z / 2 + 0.1 ], center = true); // cutout for tiered dovetail
        }
        difference()
        {
            translate([
                30.75, 7, 0
                // 1.75
            ]) rotate([ 0, cut == true ? -90 : 90, 90 ])
                dovetail(cut == true ? "female" : "male", w = 15, h = 8, slide = 30, $slop = 0.3 + tol, radius = 0.25,
                         taper = -1.5, round = true, $fn = 32);
            if (!cut == true)
                translate([ 0, -1, 0 ]) screw_holes();
        }
    }
}

module oldrose(cut, tol)
{

    core_points = [
        [ -41.4, 0, 3 ],
        [ -41.4, 34.5, 3 ],
        [ 41.4, 34.5, 3 ],
        [ 41.4, 0, 3 ],
    ];
    accent_points = [
        [ -45, 0, 0 ],
        [ -45, 36, 0 ],
        [ 45, 36, 0 ],
        [ 45, 0, 0 ],

        [ 41.3, 0, 0 ],
        [ 40, 30, 0 ],
        [ -40, 30, 0 ],
        [ -41.3, 0, 0 ],

    ];
    if (cut == true)
    {
        union()
        {
            difference()
            {
                union()
                {

                    difference()
                    {
                        linear_extrude(34.05) polygon(polyRound(core_points));
                    }
                    difference()
                    {
                        translate([ 0, 0, 19.4 ]) linear_extrude(20.05) polygon(polyRound(accent_points));

                        translate([ 0, 0, 19.4 ]) linear_extrude(34.05) polygon(polyRound(core_points));
                    }
                    translate([ -45, 0, -0.5 ]) cube([ 90, 36, 20.1 ]);
                }
                translate([ 32.5, 40, 9.5 ]) cube([ 25, 30, 21 ], center = true);
            }
            translate([ 30, 25, 9.5 ]) rotate([ 0, -90, 90 ])
                dovetail("female", w = 15, h = 8, slide = 30, $slop = tol, radius = 1, round = true, $fn = 32);

            translate([ -12.5, 36, 9.5 ]) rotate([ 0, -90, 90 ])
                dovetail("female", w = 15, h = 8, slide = 65, $slop = tol, radius = 1, round = true, $fn = 32);
        }
    }
    else
    {
        union()
        {
            difference()
            {
                union()
                {
                    difference()
                    {
                        linear_extrude(34.05) polygon(polyRound(core_points));
                    }

                    difference()
                    {
                        translate([ 0, 0, 19.4 ]) linear_extrude(20.05) polygon(polyRound(accent_points));

                        translate([ 0, 0, 19.4 ]) linear_extrude(34.05) polygon(polyRound(core_points));
                    }
                    translate([ -45, 0, -0.5 ]) cube([ 90, 36, 20.1 ]);
                }
                translate([ 32.5, 40, 9.5 ]) cube([ 25, 30, 21 ], center = true);

                // Spring Cutout
                translate([ 0.5, 5, 29.4 ]) cube([ 27.5, 10, 20 ], center = true);

                // Screw Holes
                translate([ -24.4, 6, 21.8 ]) cylinder(h = 25, d = 3.5, center = true, $fn = 20);
                translate([ -24.4, 28.4, 21.8 ]) cylinder(h = 25, d = 3.5, center = true, $fn = 20);
                translate([ 25.6, 6, 21.8 ]) cylinder(h = 25, d = 3.5, center = true, $fn = 20);
                translate([ 25.6, 28.4, 21.8 ]) cylinder(h = 25, d = 3.5, center = true, $fn = 20);

                // translate([0,0,21.8])
                //   #cylinder(h=25,d=3.5, center=true, $fn=20);
            }
            translate([ 30, 25, 9.5 ]) rotate([ 0, 90, 90 ])
                dovetail("male", w = 15, h = 8, slide = 30, $slop = tol, radius = 1, round = true, $fn = 32);

            translate([ -12.5, 36, 9.5 ]) rotate([ 0, 90, 90 ])
                dovetail("male", w = 15, h = 8, slide = 65, $slop = tol, radius = 1, round = true, $fn = 32);
        }
    }
}

// #floyd_rose(cut = false, tol = 0.05);
// #oldrose(cut = false, tol = 0.05);

difference()
{
    floyd_rose(cut = false, tol = 0.05);
//    translate([ 0, 0, 22 ]) cube([ 100, 100, 20 ], center = true);
  //  translate([ 0, -20, 0 ]) cube([ 100, 50, 25 ], center = true);
}