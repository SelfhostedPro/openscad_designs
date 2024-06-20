// External Libraries
include <BOSL2/joiners.scad>
include <BOSL2/std.scad>
include <Round-Anything/polyround.scad>

// Include other scad files
use <bridge.scad>
use <humbucker.scad>
use <neck-connection.scad>

body_core_points = polyRound(
    [
        [ 28.5, 148, 10 ], [ -27, 148, 10 ],
        //[ -28, 100, 25 ],

        [ -45, 95.5, 0 ],  // Body Right Top Connection
        [ -45, -92.7, 0 ], // Body Right Bottom Connection

        //[-36,-169,12],
        //[0,-162,0],
        //[30,-160,30],

        [ 45, -92.7, 0 ], // Body Left Bottom Connection
        [ 45, 59.8, 0 ],  // Body Left Top Connection
        [ 30, 83, 100 ]
    ],
    60);
neck_connection_points = polyRound(
    [
        [ 39.24, 65, 0 ],
        [ 45, 59.8, 0 ],
        [ 30, 83, 100 ],
        [ 28.5, 148, 10 ],
        [ -27, 148, 10 ],
        [ -45, 95.5, 0 ],
        [ -45, 65, 0 ],
    ],
    60);

module body_core(tol)
{
    difference()
    {
        union()
        {
            translate([ 0, 0, -9.915 ]) linear_extrude(20, center = true) color("green") polygon(body_core_points);
            difference()
            {
                translate([ 0, 0, 0 ]) linear_extrude(20) polygon(neck_connection_points);
                translate([ 40, 50, 12 ]) cube([ 20, 30, 25 ], center = true);
                translate([ 0.5, 120, 9.915 ])
                    cuboid([ 56.5, 90, 20.5 ], rounding = 5, edges = [ FRONT + LEFT, FRONT + RIGHT ]);
                translate([ 90, 128, 78.5 ]) sphere(100, $fn = 360);
                translate([ -93, 140, 80.5 ]) sphere(100, $fn = 360);
            }
            difference()
            {
                translate([ 32.5, -90, -9.9 ]) cube([ 25, 30, 20 ], center = true);

                // bridge screw hole
                translate([ 25.6, -100.2, 0 ]) cylinder(h = 25, d = 3.5, center = true, $fn = 32);
            }
        }
        translate([ 0, -110.7, -10 ]) floyd_rose(cut = true, tol = tol);

        translate([ 0, 111, -10.5 ]) neck_connection(cut = true, tol = tol);

        translate([ 0, -65, 10.1 ]) humbucker(cut = true, tol = tol);
        translate([ 0, -10, 10.1 ]) humbucker(cut = true, tol = tol);
        translate([ 0, 43, 10.1 ]) humbucker(cut = true, tol = tol);
        // translate([ 0, 45.5, 10.1 ]) #humbucker(cut = true, tol = tol);

        translate([ 45, -5, -10 ]) rotate([ 0, 90, 0 ])
#dovetail("female", w = 10, h = 10, slide = 170, $slop = 0.1 + tol, radius = 1, round = true, $fn = 32);
            translate([ -45, 20, -12.5 ]) rotate([ 0, -90, 0 ])
#dovetail("female", w = 10, h = 10, slide = 180, $slop = 0.1 + tol, radius = 1, round = true, $fn = 32);
    }
}

body_core(0.05);