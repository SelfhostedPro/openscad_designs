
module imported_body () {
    translate([-101,244,-20])
    import("/home/user/dev/cad/openscad/instruments/guitar/electric-guitar-body-bc-rich-warlock-model_files/Full Bodies/Full Body.stl");
}

module cutout(){
    difference(){
        cube([112.8,307.8,59.8], center=true);
        difference(){
            cube([113,315,60], center=true);
            imported_body();
        }
        // Cutout for the top left corner of the core;
        translate([0,0,-35])
        linear_extrude(70)
        polygon([
        [-32,200],
        [-33,92],
        [-100,55],
        [-100,200]
        ]);
    }
};
//cutout();
//imported_body();

module imported_body(){
    union(){
        translate([-101,244,-20])
        import("/home/user/dev/cad/openscad/instruments/guitar/electric-guitar-body-bc-rich-warlock-model_files/Main Body/Warlock Middle Top.stl");
        translate([-1,27.45,-2.2])
        cube([52,80,4], center=true);
    }
    union(){
        translate([-101,264,-20])
        import("/home/user/dev/cad/openscad/instruments/guitar/electric-guitar-body-bc-rich-warlock-model_files/Main Body/Warlock Middle Bottom.stl");
        translate([-1,-44.5,-2.2])
        cube([52,64,4], center=true);
    }
}

difference(){
    imported_body();
    //translate([50,0,0])
    //cube([100,400,100], center=true);
}
