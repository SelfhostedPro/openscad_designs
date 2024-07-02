include <BOSL2/joiners.scad>
include <BOSL2/std.scad>
include <Round-Anything/polyround.scad>

tol = 0.05;
height = 45;
bridge_size = [ 84, 35, height ];
border_size = [ 14, 2, 6 ];

module spring_cutout()
{
    cube([ 27.5, 11, 25 ], center = true);
}
module screw_holes()
{
    // Screw Holes
    translate([ -24.4, -11.5, 25 / 2 + 1 ]) cylinder(h = 100, d = 3.5, center = true, $fn = 20);
    translate([ -24.4, 11, 25 / 2 + 1 ]) cylinder(h = 100, d = 3.5, center = true, $fn = 20);
    translate([ 25.6, -11.5, 25 / 2 + 1 ]) cylinder(h = 100, d = 3.5, center = true, $fn = 20);
    translate([ 25.6, 11, 25 / 2 + 1 ]) cylinder(h = 100, d = 3.5, center = true, $fn = 20);
}

module bridge_mount(cut, tol, height)
{
    // Cutout for Dovetail (lower half towards body)
    translate([ 0, bridge_size.y / 4 + 10, bridge_size.z / 7.5 - border_size.z ]) rotate([ -45, 0, 0 ]) cuboid(
        [
            bridge_size.x + border_size.x + 5, bridge_size.x / 2.5 + border_size.x,
            cut == true ? bridge_size.z / 3 + 1 : bridge_size.z / 3 + 1.3
        ],
        rounding = 2, $fn = 20);
}

module floyd_rose(cut, tol, bridge_size = bridge_size, border_size = border_size)
{
    {
        difference()
        {
            // Bottom Half
            cuboid([ bridge_size.x + border_size.x, bridge_size.y + border_size.y, bridge_size.z / 2 ])
            {
                attach(TOP, BOTTOM)
                {
                    translate([ 0, -1, 0 ])
                        // Bridge Mounting Area
                        cuboid([ bridge_size.x, bridge_size.y, bridge_size.z / 2 - border_size.z ], rounding = 2,
                               $fn = 32, edges = [ BACK + LEFT, BACK + RIGHT ]);

                    difference() // Edge around Bridge Mounting Area
                    {
                        translate([ 0, 0, 0 ]) cuboid(
                            [ bridge_size.x + border_size.x, bridge_size.y + border_size.y, bridge_size.z / 2 ]); // top
                        if (!cut == true)
                            translate([ 0, -2.5, 0 ]) cuboid(
                                [ bridge_size.x, bridge_size.y + border_size.y, bridge_size.z / 2 + bridge_size.z ],
                                rounding = 2, $fn = 32,
                                edges = [ BACK + LEFT, BACK + RIGHT ]); // cutout plate for rest of the height
                    }
                }
            }
            // Cutout for Dovetail (lower half towards body)
            bridge_mount(cut, tol, height);
            // rotate([0,-10,0])
            //  #dovetail(cut == true ? "male" : " female",
            //           h = bridge_size.x / 4,
            //           width = bridge_size.z / 2.5,
            //           angle = -30,
            //           //taper = 1,
            //           slide = 110,
            //           round = true,
            //           radius = 1);
            // #cuboid([ bridge_size.x + border_size.x + 1, 12, bridge_size.z - bridge_size.z / 1.5 ], rounding = 2,
            // edges = [FRONT+TOP, FRONT+BOTTOM], $fn=20); cube([ bridge_size.x + border_size.x + 1, 12, bridge_size.z -
            // bridge_size.z / 2 ],
            //      center = true); // cutout for dovetail
            if (!cut == true)
            {
                translate([ 0, -1, 0 ]) screw_holes();
                translate([ 0.5, -bridge_size.y / 2 + 3.5, bridge_size.z / 2 - 2 ]) spring_cutout();
            }
        }
        // difference()
        // {
        //     //translate([ 0, 6.2, 2 ]) rotate([ 0, cut == true ? -90 : 90, 90 ])
        //         //br_dovetail(cut = cut, bridge_size = bridge_size, border_size = border_size, tol = tol);
        //     if (!cut == true)
        //         translate([ 0, -1, 0 ]) screw_holes();
        // }
    }
}

module br_dovetail(cut = false, tol = tol, bridge_size = bridge_size, border_size = border_size)
{
    dovetail(cut == true ? "female" : "male", w = cut == true ? 15 : 15 - 0.4, h = cut == true ? 10.2 : 10.2 - 0.2,
             slide = bridge_size.x + border_size.x, $slop = tol, radius = 0.25, round = true, $fn = 32);
}

difference()
{
    floyd_rose(cut = false, tol = 0.05);
    // translate([0,-12,0])
    // cube([100,30,40], center=true);
    // translate([0,0,25])
    // cube([100,40,15], center=true);
    // br_dovetail();
}