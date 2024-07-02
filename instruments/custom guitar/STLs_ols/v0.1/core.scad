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

        [ -45, 95.5, 0 ],  // Body Right Top Connection
        [ -45, -92.7, 0 ], // Body Right Bottom Connection

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
            translate([ 0, 0, -9.915 ]) linear_extrude(22, center = true) color("green") polygon(body_core_points);
            difference()
            {
                #translate([ 0, 0, 0 ]) linear_extrude(20) polygon(neck_connection_points);
                translate([ 40, 50, 12 ]) cube([ 20, 30, 25 ], center = true);
                translate([ 0.5, 120, 9.915 ])
                 cuboid([ 56.5, 90, 20.5 ], rounding = 5, edges = [ FRONT + LEFT, FRONT + RIGHT ]);
                translate([ 90, 128, 78.5 ]) sphere(100, $fn = 360);
                translate([ -93, 140, 80.5 ]) sphere(100, $fn = 360);
            }
            difference()
            {
                // cube for bridge extension
                translate([ 0, -97.5, -4.94 ]) cube([ 90, 15, 31.95 ], center = true);

                // bridge screw holes
                translate([ 25.6, -101.5, 0 ]) cylinder(h = 40, d = 3.5, center = true, $fn = 32);
                translate([ -24.4, -101.5, 0 ]) cylinder(h = 40, d = 3.5, center = true, $fn = 32);
            }

            // support section above bridge
            translate([ 0, -83.7, 6 ]) cuboid([ 90, 18, 10 ], chamfer = 10, edges = [BACK+TOP]);
        }
        translate([ 0, -111.7, -11 ]) floyd_rose(cut = true, tol = tol);

        translate([ 0, 111, -11.6 ]) neck_connection(cut = true, tol = tol);

        translate([ 0, -52, 11.1 ]) humbucker(cut = true, tol = tol);
        translate([ 0, -5, 11.1 ]) humbucker(cut = true, tol = tol);
        translate([ 0, 43, 11.1 ]) humbucker(cut = true, tol = tol);
        // translate([ 0, 45.5, 10.1 ]) #humbucker(cut = true, tol = tol);

        translate([ 45, 10, -12.5 ]) rotate([ 0, 90, 0 ])
            dovetail("female", w = 10, h = 10, slide = 170, $slop = 0.1 + tol, radius = 1, round = true, $fn = 32);
        translate([ -45, 25, -12.5 ]) rotate([ 0, -90, 0 ])
            dovetail("female", w = 10, h = 10, slide = 200, $slop = 0.1 + tol, radius = 1, round = true, $fn = 32);
    }
}

difference(){
    body_core(0.05);
}