module single_pickup () {
//difference(){
//        translate([157.5,284,40])
//        #cube([87,31,30], center=true);
difference(){
        translate([157.5,284,40])
        #cube([87,31,20], center=true);
    
        import("/Users/none/dev/cad/openscad/openscad_designs/instruments/guitar/headless-electric-guitar-v3-model_files/STL/BODY - CENTER.stl");
    };
}
//}
difference(){
translate([-154,-290,-30])
single_pickup();
translate([45,6.5,-2])
linear_extrude(50)

polygon([
    [2,3.5],
    [-10,4],
    [3,-8]
]);
}