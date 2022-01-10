module uhf_spacer(
  size=[35, 35, 18],
  bolt_spacing=17.5,
  bolt_d=4.2,
  center_d=17,
  cb_depth=0,
  cb_diameter=0,
  $e=1
) {

  difference() {
    translate([0,0, size[2]/2])
      cube(size, center=true);
  
    if (center_d > 0) {
      translate([0, 0, 0-$e])
      cylinder(r=center_d/2, h=size[2]+(2*$e));
    }

    for (i = [0 : 1 : 3]) {
      rotate([0, 0, i*90])
      translate([bolt_spacing/2, bolt_spacing/2, 0-$e]) {
        cylinder(r=bolt_d/2, h=size[2]+(2*$e));
        if (cb_depth > 0) {
          translate([0, 0, size[2] - cb_depth])
            cylinder(r=cb_diameter/2, h=cb_depth+(2*$e));
        }
      }
    }
  }
}

uhf_spacer();
