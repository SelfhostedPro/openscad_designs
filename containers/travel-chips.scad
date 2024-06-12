size = 34;
height = 1;
space = 0.5;
thickness = 1;


module coin () {
    cylinder(h=height+space,d=size+space, $fn=120, center=true);
}

module case () {
    cylinder(height + thickness * 2, d=size + thickness,center=true);
}

difference (){
case();
coin();
cube([10,10,5]);
}
