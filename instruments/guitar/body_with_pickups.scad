
module imported_body(){
import("/Users/none/dev/cad/openscad/openscad_designs/instruments/guitar/guitar-missing-pickups.stl");
}
module single_pickup(){
    import("/Users/none/dev/cad/openscad/openscad_designs/instruments/guitar/single_pickup.stl");

}

difference(){
    imported_body();
    translate([0,62,2])
    single_pickup();
    translate([0,17,2])
    rotate([0,0,-15])
    single_pickup();
    translate([27,48,13])
    rotate([90,90,0])
    #cylinder(30,d=11, $fn=40);
}
