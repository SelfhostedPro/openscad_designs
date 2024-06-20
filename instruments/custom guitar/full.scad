// External Libraries
include <BOSL2/joiners.scad>
include <BOSL2/std.scad>
include <Round-Anything/polyround.scad>

// Include other scad files
use <bridge.scad>
use <core.scad>
use <humbucker.scad>
use <neck-connection.scad>

/* [Parts] */
// CSV list of parts to display (core,left,right,floyd_rose,neck_connection, humbucker)
Parts = "core,floyd_rose,neck_connection";

/* [Printer] */
// Tolerance for connections
Tolerance = 0.05; //[0:0.01:1]

/* [DEBUG] */
// Show debug model
DEBUG_MODEL = "false"; //[false,true,"HIGHLIGHT"]

/* [Hidden] */

body_p_left = polyRound(
    [

        //[46,27,35],
        [ 45, -174, 0 ], // Bottom Connection

        [ 58, -190, 9 ], [ 102, -143, 90 ],

        [ 152, -129, 5 ], [ 158.5, -117, 25 ], [ 83, -33, 93 ],

        [ 155, 93, 13 ], [ 63, 37.8, 80 ], [ 45, 59.8, 0 ], // Top Connection
        //[28.5,-162,0],
    ],
    100);

body_p_right = polyRound(
    [
        [ -45, 100, 5 ],

        [ -160, 130, 5 ],

        [ -100, 0, 5 ],

        [ -165, -140, 5 ],

        [ -90, -230, 5 ], [ -55, -230, 5 ]
    ],
    60);

module body_left()
{
    translate([ 0, 0, -9.915 ])
        // color("blue")
        linear_extrude(20, center = true) polygon(body_p_left);
}

module body_right()
{
    translate([ 0, 0, -9.915 ])
    {
        color("purple")
            // linear_extrude(30)
            polygon(body_p_right);
    }
}

// Testing //

// Test Prints //
difference()
{
    // floyd_rose();
    // translate([-50,-100,0])
    // #cube([100,100,50], center=true);
    // translate([30,-111,25])
    // #cube([100,40,50], center=true);
    // body_core();
    // translate([0,-25,0])
    // cube([100,200,50], center=true);
}

// translate([1,110,-10.5])
// neck_connection();

// translate([-99,125.5,-9])
//%import("/Users/none/dev/cad/openscad/openscad_designs/instruments/guitar/electric-guitar-body-bc-rich-warlock-model_files/Main
//Body/Warlock Middle Top.stl"); translate([-157,-233.4,-30]) %import("/Users/none/Downloads/GUITAR V3 union
//plate.stl");

// Reference //
module imported_body()
{
    translate([ -157, -232, -30 ])
    {
        import("/Users/none/dev/cad/openscad/openscad_designs/instruments/guitar/headless-electric-guitar-v3-model_files/STL/BODY - CENTER.stl");
        import("/Users/none/dev/cad/openscad/openscad_designs/instruments/guitar/headless-electric-guitar-v3-model_files/STL/BODY - LOWER LEFT.stl");
        import("/Users/none/dev/cad/openscad/openscad_designs/instruments/guitar/headless-electric-guitar-v3-model_files/STL/BODY - RIGHT.stl");
        import("/Users/none/dev/cad/openscad/openscad_designs/instruments/guitar/headless-electric-guitar-v3-model_files/STL/BODY - UPPER LEFT.stl");
        // Core structure
        //import("/Users/none/Downloads/GUITAR V3 - Structure (no plate).stl");
    }
}

if (DEBUG_MODEL == "true")
    % imported_body();
else if (DEBUG_MODEL == "HIGHLIGHT")
#imported_body();

    show_parts = str_split(Parts, ",");

for (part = [0:len(show_parts)])
{
    if (show_parts[part] == "core")
    {
        body_core(tol = Tolerance);
    }
    if (show_parts[part] == "left")
    {
        body_left();
    }
    if (show_parts[part] == "right")
    {
        body_right();
    }
    if (show_parts[part] == "floyd_rose")
    {
        translate([ 0, -111.7, -10 ]) floyd_rose(cut=false,0.05);
    }
    if (show_parts[part] == "neck_connection")
    {
        translate([ 0, 111.5, -9 ]) neck_connection(cut = false, tol = Tolerance);
    }
    if (show_parts[part] == "humbucker")
    {
        translate([ 0, -70.5, 10.1 ]) humbucker(cut = false, holes = true, tol = Tolerance);
    }
}