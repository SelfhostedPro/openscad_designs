bp_size=[250,253,100];

module core(){
    translate([0,-27.5,0])
    import("/home/user/dev/cad/openscad/instruments/guitar/guitar-core.stl");
}

module build_plate(){
    cube(bp_size, center=true);
}

module cut_bp(){
    difference(){
        cube([bp_size.x-1, bp_size.y-1, bp_size.z-1], center=true);
        difference(){
            build_plate();
            core();
        };
    };
}

//core();
//build_plate();
cut_bp();
//#core();