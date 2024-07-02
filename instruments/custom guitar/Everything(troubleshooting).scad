// External Libraries
include <BOSL2/joiners.scad>
include <BOSL2/std.scad>
include <Round-Anything/polyround.scad>

// Include other scad files
use <bridge.scad>
use <center.scad>
use <pickups.scad>
use <neck-connection.scad>
use <right.scad>


/* [Display] */
// CSV list of parts to display (core,left,right,floyd_rose,neck_connection, humbucker)
Parts = "center,floyd_rose,neck_connection";

/* [Parts] */
// CSV List of pickup configuration (humbucker/single) (ie. "humbucker,single,single", "humbucker,humbucker")
Pickups = ["humbucker", "single", "single"];

// Which type of bridge (*ffloyd_rose = fixed floyd rose)
Bridge = "ffloyd_rose"; // ["ffloyd_rose", "none"]

/* [Printer] */
// Tolerance for connections
Tolerance = 0.05; //[0:0.01:1]

/* [DEBUG] */
// Show debug model
DEBUG_MODEL = "false"; //[false,true,"HIGHLIGHT"]

/* [Hidden] */



body_p_left = polyRound(
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
    {
        color("purple")
            // linear_extrude(30)
            polygon(body_p_left);
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
        //translate([ -157, 920, 10
        //])
    //import("/Users/none/Downloads/black_core.stl");

    }
}

if (DEBUG_MODEL == "true")
    % imported_body();
else if (DEBUG_MODEL == "HIGHLIGHT")
#imported_body();

    show_parts = str_split(Parts, ",");
    

for (part = [0:len(show_parts)])
{
    if (show_parts[part] == "center")
    {
        center(tol = Tolerance);
    }
    if (show_parts[part] == "left")
    {
        body_left();
    }
    if (show_parts[part] == "right")
    {
        translate([0,0,-7])
        %body_right();
    }
    if (show_parts[part] == "floyd_rose")
    {
        translate([ -1, -109.9, -18.2 ]) floyd_rose(cut=false,0.05);
    }
    if (show_parts[part] == "neck_connection")
    {
        translate([ 0, 111.5, -9 ]) neck_connection(cut = false, tol = Tolerance);
    }
    if (show_parts[part] == "humbucker")
    {
        translate([ -2.5, -67, 10 ]) pickup_slider("humbucker",cut = false, top = true, right=true, tol = Tolerance);
    }
    if (show_parts[part] == "single")
    {
        translate([ -2.5, 55, 10 ]) #single(tol=0.05);
        //translate([ -2.5, -67, 10 ]) pickup_slider("single",cut = false, top = true, right=true, tol = Tolerance);
    }
}