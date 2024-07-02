include <BOSL2/joiners.scad>
include <BOSL2/std.scad>
include <Round-Anything/polyround.scad>
$fn = 32;
body_p_right = polyRound(
    [

        //[46,27,35],
        [ 48, -174, 0 ], // Bottom Connection

        [ 58, -190, 9 ], [ 102, -143, 90 ],

        [ 152, -129, 5 ], [ 158.5, -117, 25 ], [ 83, -33, 93 ],

        [ 155, 93, 13 ], [ 63, 37.8, 80 ], [ 48, 56.5, 0 ], // Top Connection
        //[28.5,-162,0],
    ],
    100);
body_p_plate = [
    [ 48, -174 ], // Bottom Connection

    [ 58, -190 ],
    [ 102, -143 ],

    [ 152, -129 ],
    [ 158.5, -117 ],
    [ 83, -33 ],

    [ 155, 93 ],
    [ 63, 37.8 ],
    [ 48, 56.5 ],
];
module shell()
{
    linear_extrude(45, center = true) shell2d(-2)
    {
        polygon(body_p_right);
        translate([ 93, -55, 0 ]) rotate([ 0, 0, 0 ]) union()
        {
            grid_copies(spacing = 34.6, size = [ 100, 240 ], stagger = "alt") rotate([ 0, 0, 90 ]) difference()
            {
                hexagon(d = 40);
                hexagon(d = 36);
            };
        }
    };
    translate([ 0, 0, 0 ]) linear_extrude(43, center = true) shell2d(-2)
    {
        polygon(body_p_right);
        translate([ 100, -100, 0 ]) rotate([ 0, 0, 0 ]) union()
        {
            grid_copies(spacing = 34.6, size = [ 150, 100 ], stagger = "alt") rotate([ 0, 0, 90 ]) difference()
            {
                hexagon(d = 40);
            };
        }
    };
}

module front_plate_base()
{
    intersection()
    {
        translate([ 0, 0, 21 ]) linear_extrude(3, center = true) difference()
        {
            translate([ 85, -92, 0 ]) square([ 150, 150 ], center = true);
            translate([ 70, 24, 0 ]) difference()
            {
                square([ 140, 142 ], center = true);
                translate([ -2.9, -81, 0 ]) rotate([ 0, 0, 90 ]) hexagon(d = 40);
translate([ 31.6, -81, 0 ]) rotate([ 0, 0, 90 ]) hexagon(d = 40);
            }
            translate([ 67, -184.5, 0 ]) rotate([ 0, 0, 90 ]) hexagon(d = 60);
        }
        shell();
    }
}

module front_plate()
{
    difference()
    {
        front_plate_base();
        
        translate([ 60, -108, 18 ]) fw_switch();
        translate([ 67, -55, 17 ]) pothole();
        translate([ 84, -85, 17 ]) pothole();
        translate([ 102, -115, 17 ]) pothole();
        // Mounting holes
        translate([81, -157, 17]) cylinder(10, d=3, center=true);
        translate([101, -40.5,17]) cylinder(10, d=3, center=true);
    }
}

module body()
{
    difference()
    {
        shell();
        difference(){
            translate([ 0, 0, -20.5 ]) linear_extrude(43) difference()
            {
                translate([ 5.5, -6.5, 0 ]) scale([ 0.94, 0.94, 1 ]) polygon(body_p_right);
                translate([ 70, 25, 0 ]) square([ 140, 142 ], center = true);
                translate([ 66.5, -175, 0 ]) rotate([ 0, 0, 90 ]) circle(d = 45, $fn = 6);
                translate([81,-158,0]) square([10,10], center=true);
            }
            // Keep shell from shaping for back
            translate([100,-70,-58.4])
            rotate([0,-15,0])
            cube([200,300,100], center=true);
        }
        front_plate_base();
        translate([ 50, -83, 13 ]) cablehole();
        translate([ 50, -144, -7 ]) rotate([ 0, 0, 90 ]) iohole();
        
        // Screw Holes
        translate([101, -40.5,16.5]) cylinder(7,d=5,center=true);
        translate([81, -157,16.5]) cylinder(7,d=5,center=true);
        
        // Pot Spacing
        translate([67, -52, 7.2]) cylinder(25, d=25, center=true);
        
        // Shaping
        translate([100,-70,-60.4])
        rotate([0,-15,0])
        cube([200,300,100], center=true);
    }
    translate([ 48, -10, -8 ])
    rotate([0,-90,0])
        dovetail("male", h = 4.9, w = 9.6, slide = 120,  $slop = 0.05, radius = 0.25, round = true, $fn = 32);
}

module fw_switch()
{
    union()
    {
        cube([ 3, 29, 10 ], center = true);
        translate([ 0, 20.25, 0 ]) cylinder(h = 10, d = 4, center = true, $fn = 20);
        translate([ 0, -20.25, 0 ]) cylinder(h = 10, d = 4, center = true, $fn = 20);
    }
}

module pothole(high = false)
{
    cylinder(h = 10, d = 10, $fn = 20, center = true);
}

module iohole(sliding = false)
{
    rotate([ 0, 90, 90 ]) cylinder(h = 10, d = 10.1, $fn = 20, center = true);
    if (sliding)
        translate([ 0, 0, -25 ]) cube([ 10, 10, 50 ], center = true);
}

module cablehole()
{
    translate([ 0, 6, 4 ]) cube([ 10, 20, 10 ], center = true);
    hull()
    {
        rotate([ 0, 90, 0 ]) cylinder(h = 20, d = 8, center = true);
        translate([ 0, 12, 0 ]) rotate([ 0, 90, 0 ]) cylinder(h = 20, d = 8, center = true);
    }
}

module electronics_connection(tol = 0.05)
{
    translate([ 79, -50, 0 ]) difference()
    {
        cube([ 62, 120, 35 ], center = true);
        translate([ 0, 0, -2 ]) cube([ 60, 118, 35 ], center = true);
        translate([ -20, 20, 13 ]) rotate([ 0, 0, 0 ]) fw_switch();

        // Pot Holes
        translate([ 15, 35, 13 ]) pothole(high = false);
        // translate([ 15, 35, 10 ]) #cylinder(h = 5, d = 25, $fn = 20, center = true);

        translate([ 15, -2, 13 ]) pothole(high = false);
        // translate([ 15, -2, 10 ]) #cylinder(h = 5, d = 25, $fn = 20, center = true);

        translate([ 15, -35, 13 ]) pothole(high = false);
        // translate([ 15, -35, 10 ]) #cylinder(h = 5, d = 25, $fn = 20, center = true);

        // IO Hole
        translate([ -9, -60, 4 ]) iohole(sliding = true);

// Cable hole from body to right
#translate([ -30, -33, 6 ]) cablehole();
    }
    translate([ 48, -50, -12 ]) rotate([ 0, -90, 0 ]) dovetail("male", h = 5, w = 9.7, slide = 40, $slop = 0.1 + tol,
                                                               angle = 0, radius = 0.25, round = true, $fn = 32);
}

module electronics_compartment(tol = 0.05)
{
    union()
    {
        translate([ 79, -50, -4 ]) difference()
        {
            cube([ 58.5, 116.5, 2 ], center = true);
            // translate([ 0, 0, -2 ]) cube([ 57, 115, 40 ], center = true);
            translate([ -20, 20, 0 ]) rotate([ 0, 0, 0 ]) fw_switch();

            // Pot Holes
            translate([ 15, 35, 0 ]) pothole(high = false);
            // translate([ 15, 35, 10 ]) #cylinder(h = 5, d = 25, $fn = 20, center = true);

            translate([ 15, -2, 0 ]) pothole(high = false);
            // translate([ 15, -2, 10 ]) #cylinder(h = 5, d = 25, $fn = 20, center = true);

            translate([ 15, -35, 0 ]) pothole(high = false);
            // translate([ 15, -35, 10 ]) #cylinder(h = 5, d = 25, $fn = 20, center = true);

            // IO Hole
            // translate([ -10, -60, 4 ]) iohole();

            // Cable hole from body to right
            // translate([ -30, -33, 10 ]) cablehole();
            // translate([ 15, 35, -20 ]) cube([ 58.5, 50, 40 ], center=true);
        }
    }
}

module body_right(tol = 0.05)
{
    difference()
    {
        // body();
        //  translate([ 0, 0, 21 ]) top_plate();
    }
    translate([ 200, 0, 0 ]) front_plate();
    body();

    // translate([ 100, 100, 0 ])

    // electronics_connection(tol);
    //  electronics_compartment();
    //   linear_extrude(40, center = true) polygon(body_p_left);
}

front_plate();
body();