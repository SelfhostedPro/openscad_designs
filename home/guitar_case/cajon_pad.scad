include <BOSL2/std.scad>
$fn=100;
cuboid([ 220, 220, 10 ], rounding = 5, edges = [ TOP, FRONT + RIGHT, FRONT + LEFT, BACK + RIGHT, BACK + LEFT ]);