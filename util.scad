/**
 * A groove for a pair of wires
 * @param diameter of wire
 * @param length of each wire groove
 * @param angle in degrees
 */
module vpole_groove(
  d=5,
  l=10,
  angle=120
) {
  union() {
    for (i = [-1, 1]) {
      translate([0, 0, d/2])
      rotate([0, 0, -i * angle * 0.5])
      rotate([90, 0, 0]) {
        cylinder(r=d/2, h=l);
        translate([0,d/4, l/2])
          cube([d, d/2, l], center=true);
      }
    }
    cylinder(r=d, d);
  }
}

module fillet(r=10, h=100, extra=0) {
  difference() {
    translate([0-extra, 0-extra, 0])
      cube([r+extra, r+extra, h]);
    translate([r, r, 0])
      cylinder(r=r, h=h+2);
  }
}

