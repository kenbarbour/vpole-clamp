module uhf_spacer(
  size=[40, 40, 18],
  bolt_spacing=17.5,
  bolt_offset=[0,0],
  bolt_d=3.5,
  center_d=16,
  cb_depth=0,
  cb_diameter=0,
) {

  difference() {
    translate([0,0, size[2]/2])
      cube(size, center=true);
  
    if (center_d > 0) {
      cylinder(r=center_d/2, h=size[2]);
    }

    for (i = [0 : 1 : 3]) {
      rotate([0, 0, i*90])
      translate([bolt_spacing/2, bolt_spacing/2, 0]) {
        cylinder(r=bolt_d/2, h=size[2]);
        if (cb_depth > 0) {
          translate([0, 0, size[2] - cb_depth])
            cylinder(r=cb_diameter/2, h=cb_depth+1);
        }
      }
    }
  }
}

uhf_spacer();
