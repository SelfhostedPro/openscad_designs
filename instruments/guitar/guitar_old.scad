include <Round-Anything/polyround.scad>


module og_body (){
//color("red")
  translate([-100,270,-20])
  import("/home/user/dev/cad/openscad/instruments/guitar/electric-guitar-body-bc-rich-warlock-model_files/Main Body/Warlock Middle Bottom.stl");
};



module center_block (){
    cube([100,252,50], center=true);
}

module humbucker (){
    topside_points = [
            [-35 , 0,  3.5],
        [ 35, 0,  3.5 ],
    ];
    bottomside_points = [
            [ 35 , 39,  3.5],
        [-35,  39,  3.5],
    ];
    sidea_points = [
        [ 35, 13, 3.5],
        [ 45, 13, 3.5],
        [ 45, 26, 3.5],
        [ 35, 26, 3.5],
    ];
    sideb_points = [
        [ -35, 26, 3.5],
        [ -45, 26, 3.5],
        [ -45, 13, 3.5],
        [ -35, 13, 3.5],
    ];
    
    all_points = concat(
        topside_points,
        sidea_points,        
        bottomside_points,
        sideb_points,
    );
    
    union(){
        //core section
        linear_extrude(3)
        polygon(polyRound(all_points,30));  
    };
}


og_body();
translate([0,-56,0])
#humbucker();
//center_block();