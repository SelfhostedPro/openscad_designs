








module knob()
{
    difference(){
    cylinder(h = 20, d = 25, center = true, $fn = 360);
    translate([ 0, 0, -5 ]) cylinder(h = 11, d = 6.1, center = true, $fn = 360);
    }
}

difference()
{
    knob();
    translate([ 0, 0, 9.1 ]) linear_extrude(2, center = true)
        text("VOL", font = "Comic Sans MS:style=Bold", size = 7, halign = "center", valign = "center", $fn = 32);
}

translate([ 30, 0, 0 ]) difference()
{
    knob();
    translate([ 0, 0, 9.1 ]) linear_extrude(2, center = true)
        text("TONE", font = "Comic Sans MS:style=Bold", size = 7, halign = "center", valign = "center", $fn = 32);
}

translate([ 0, 30, 0 ]) difference()
{
    knob();
    translate([ 0, 0, 9.1 ]) linear_extrude(2, center = true)
        text("VOL", font="HeavyData Nerd Font:style=Regular", size = 10, halign = "center", valign = "center", $fn = 32);
}

translate([ 30, 30, 0 ]) difference()
{
    knob();
    translate([ 0, 0, 9.1 ]) linear_extrude(2, center = true)
        text("TONE", font="HeavyData Nerd Font Propo:style=Regular", size = 10, halign = "center", valign = "center", $fn = 32);
}


//translate([ 40, -11.5, -9 ]) import("/Users/none/Downloads/A_Knob.stl");