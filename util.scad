
module fillet(r=10, h=100, extra=0) {
  difference() {
    translate([0-extra, 0-extra, 0])
      cube([r+extra, r+extra, h]);
    translate([r, r, 0])
      cylinder(r=r, h=h+2);
  }
}

