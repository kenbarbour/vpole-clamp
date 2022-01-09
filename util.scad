
module fillet(r=10, h=100) {
  difference() {
    cube([r, r, h]);
    translate([r, r, -1])
      cylinder(r=r, h=h+2);
  }
}

