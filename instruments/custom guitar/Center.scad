// External Libraries
include <BOSL2/joiners.scad>
include <BOSL2/std.scad>
include <Round-Anything/polyround.scad>

// Include other scad files
use <bridge.scad>
use <neck-connection.scad>
use <pickups.scad>
// use <core.scad>

// Tolerance for connections
tolerance = 0.05;

/* [Size] */
// Thickness of the body
height = 45;
// Width of the center
width = 98;

/* [ROUTING] */
// cut out holes for routing switches or for active pickups
Passthrough_Cable_Holes = "lower"; //[none,lower,upper]

/* [DEBUG] */
// Show debug model
DEBUG_MODEL = "false"; //[false,true,"HIGHLIGHT"]

body_points = [[width / 3.5 + 0.5, 148, 10], // Neck Connection Left
               [-width / 3.5 + 1, 148, 10],  // Neck Connection Right
               [-width / 2 - 1, 95.5, 0],    // Body Right Top Connection
               [-width / 2 - 1, -91.85, 0],  // Body Right Bottom Connection
               [width / 2 - 1, -91.85, 0],   // Body Left Bottom Connection
               [width / 2 - 1, 56.5, 0],     // Body Left Top Connection
               [width / 3.5 + 2, 83, 100]    // Neck Connection Arch on Left
];

body_core_points = polyRound(body_points, 55);

module center(tol = tolerance, height = height, width = width, passthrough_cable_holes = Passthrough_Cable_Holes)
{
    union()
    {
        difference()
        {
            // Main Body Shape
            translate([ 0, 0, -7 ]) linear_extrude(height, center = true) polygon(body_core_points);
            ;
            translate([ 0, 111, -12.5 ])
                neck_connection(size = [ width / 2 + 2, width / 2 + 12, height ], cut = true, tol = 0.05);
            // stylized shape for neck connection
            translate([ width - 8, 128, 101.5 ]) sphere(120, $fn = 360);
            translate([ -width + 6.5, 148, 75.5 ]) sphere(100, $fn = 360);
            // cutout for the neck connection
            translate([ 0.5, 120, 9.915 ])
                cuboid([ width / 2 + 7.5, 87, 22.5 ], rounding = 5, edges = [ FRONT + LEFT, FRONT + RIGHT ]);
            pickup_slots(tol = tolerance);
            side_rails();

            // chamfer bottom edges for better strength
            translate([ width / 2 + 1, 0, -30 ]) rotate([ 90, 0, 0 ]) chamfer_edge_mask(l = 300, chamfer = 5);
            translate([ -width / 2 - 3, 0, -30 ]) rotate([ -90, 0, 0 ]) chamfer_edge_mask(l = 300, chamfer = 5);

            if (passthrough_cable_holes == "lower")
                translate([ 0, -80, -20 ]) rotate([ 0, 90, 0 ]) cylinder(120, d = 5, center = true);
            if (passthrough_cable_holes == "upper")
                translate([ 0, -10, -23 ]) rotate([ 0, 90, -55 ]) cylinder(200, d = 5, center = true);
        }
        difference()
        {
            translate([ -1, 0, 0 ]) bridge_connection(98, height);
            translate([ width / 2 - 1, 0, -30 ]) rotate([ 90, 0, 0 ]) chamfer_edge_mask(l = 300, chamfer = 5);
            translate([ width / 2 - 3, 0, -30 ]) rotate([ -90, 0, 0 ]) chamfer_edge_mask(l = 300, chamfer = 5);
        }
    }
}

module pickup_slots(tol = tolerance)
{
    union()
    {
        translate([ -4.9, -16.5, 12.5 ]) cube([ 100, 144.1, 21 ], center = true);
        translate([ -2.6, -67, 10 ]) pickup_slider("humbucker", tol = tolerance, cut = true, top = true, right = true);
        translate([ -2.6, -15, 10 ]) pickup_slider("humbucker", tol = tolerance, cut = true, top = true, bottom = true);
        translate([ -2.6, 34, 10 ]) pickup_slider("humbucker", tol = tolerance, cut = true, bottom = true);
    }
}

module bridge_connection(width, height, tol = tolerance)
{
    difference()
    {
        translate([ 0, -104.3, -height / 4 - 0.9 ]) cube([ width, 25, height / 1.3 ], center = true);
        translate([ 0, -110.35, -18.25 ]) floyd_rose(cut = true, tol = tol);
        // Screw Holes
        translate([ -24.4, -100.3, 25 / 2 + 1 ]) cylinder(h = 100, d = 3.5, center = true, $fn = 20);
        translate([ 25.6, -100.3, 25 / 2 + 1 ]) cylinder(h = 100, d = 3.5, center = true, $fn = 20);
    }
}

module side_rails(tol = tolerance)
{
    // difference()
    // {
    translate([ -100 / 2, 30, -height / 3 ]) rotate([ 0, -90, 0 ])
        dovetail("female", h = 5, w = 10, slide = 200, $slop = tolerance, radius = 0.25, round = true, $fn = 32);
    translate([ 100 / 2 - 2, 30, -height / 3 ]) rotate([ 0, 90, 0 ])
        dovetail("female", h = 5, w = 10, slide = 200, $slop = tolerance, radius = 0.25, round = true, $fn = 32);
    // }
}

// translate([100,0,0])
// %body_core(tolerance);

// Reference //
module imported_body()
{
    translate([ -157, -232, -30 ])
    {
        // clang-format off
        // import("/Users/none/dev/cad/openscad/openscad_designs/instruments/guitar/headless-electric-guitar-v3-model_files/STL/BODY - CENTER.stl");
        // import("/Users/none/dev/cad/openscad/openscad_designs/instruments/guitar/headless-electric-guitar-v3-model_files/STL/BODY - LOWER LEFT.stl");
        // import("/Users/none/dev/cad/openscad/openscad_designs/instruments/guitar/headless-electric-guitar-v3-model_files/STL/BODY - RIGHT.stl");
        // import("/Users/none/dev/cad/openscad/openscad_designs/instruments/guitar/headless-electric-guitar-v3-model_files/STL/BODY - UPPER LEFT.stl");
        // // Core structure
        // import("/Users/none/Downloads/GUITAR V3 - Structure (no plate).stl");
        translate([-550,-280.5,0])
        rotate([0,0,90])
        import("/Users/none/Downloads/black_core.stl");
        // clang-format on
    }
}

if (DEBUG_MODEL == "true")
    % imported_body();
else if (DEBUG_MODEL == "HIGHLIGHT")
#imported_body();

    difference()
    {
        center();

        // For checking bridge connection
        // translate([0,35,0])
        // cube([100,250,50],center=true);

        // For checking pickup slots
        // translate([ 0, 55, 0 ]) #cube([ 100, 200, 50 ], center=true);
        // translate([ 0, -115, 0 ]) #cube([ 100, 50, 50 ], center=true);
        //     translate([ 0, -60, -16 ]) #cube([ 100, 80, 20 ], center=true);
    }