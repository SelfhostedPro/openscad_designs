include <BOSL2/hinges.scad>
include <BOSL2/std.scad>
use <hinge.scad>;

length = 100;
width = 20;
height = 15;
tol = 0.3;
$fn = 100;

gap = 0.2;

module base(height = height, length = length, width = width, tol = tol, $fn = $fn, gap = gap)
{
    cuboid([ height / 2 - tol, length - length / 4, width ], anchor = FRONT)
    {
        position(FRONT + RIGHT) orient(anchor = LEFT, 0) rotate([ 90, 0, 0 ])
            translate([ 0, 0, 0 ])
                knuckle_hinge(length = width, segs = 5, arm_angle = 54, offset = height / 3.5, knuckle_diam = height / 2, arm_height = 0,
                    anchor = BOT + FRONT, clear_top = true, gap = gap,
                    pin_diam = height / 4 - tol, inner = true)
                    attach(CENTER, CENTER)
                        rotate([ 0, 90, 0 ])
                            cylinder(width, d = height / 4);
        position(FRONT + RIGHT) translate([ -height / 8, 0, 0 ])
            cuboid([ height / 4, length / 2, width ])
                translate([ 0, -length / 30, 0 ])
                    position(FRONT + LEFT)
                        cuboid([ height / 2, width, width ], edges = [BOT + LEFT], chamfer = 1.5, anchor = TOP, orient = FRONT);
        position(BACK + RIGHT)
            translate(v = [ 0, -1.3, 0 ])
                cuboid([ height + 2 + tol, 1.5, width ], anchor = FRONT + RIGHT)
                    position(FRONT + LEFT) wedge(size = [ width, 2, 2 ], anchor = BOT + BACK, orient = FWD, spin = 90);

        // prismoid([ height / 3, width ], [ height / 2, width ], h = width, shift = [ -0.83, 0 ], anchor = CENTER, orient = FRONT);
    }
}
module clip(height = height, length = length, width = width, tol = tol, $fn = $fn, gap = gap)
{
    cuboid([ height / 2, length - length / 3.8, width ], anchor = FRONT)
        position(FRONT + LEFT) orient(anchor = RIGHT, 0) rotate([ 90, 0, 0 ])
            translate([ 0, 0, 0 ])
                knuckle_hinge(length = width, segs = 5, arm_angle = 57, offset = height / 3.5, knuckle_diam = height / 2, arm_height = 0,
                    anchor = BOT + FRONT, clear_top = true, gap = gap,
                    inner = false, pin_diam = height / 4 + tol);
    //     position(FRONT) orient(anchor = RIGHT) rotate([ 90, 0, 0 ])
    //         // translate([ 0, height / 9, 0 ])
    //             cylinder(width, d = height / 2, center=true);
}
translate(v = [ 0, 0, 0 ])
    // translate(v = [ height / 4 + 0.4, -height / 4 - 0.6, 0 ])
    // rotate([ 0, 0, -90 ])
    base();
// translate(v = [ -height / 2, 0, 0 ])
translate(v = [ -height / 1.78, -height / 1.93, 0 ])
    rotate([ 0, 0, 90 ])
        clip();