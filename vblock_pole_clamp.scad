use <util.scad>

module vblock_pole_clamp(
  angle=120,         // angle of the clamp
  h=27,              // height or thickness
  w=80,              // overall width of clamp (x axis)
  d=10,              // depth of clamp (y axis)
  offset=5,          // defines thickness at the deepest part of the v
  bolt_center=45,    // distance between bolt centers (min)
  bolt_diameter=9,   // clearance diameter of bolts
  bolt_slot=10,      // slot bolt holes (0 is a circular hole)
  corner_radius=3,
  $e=1
) {
  difference() {

    // Main cube
    translate([0, w/-2, 0])
      cube([d, w, h]);

    // Fillet corners [x, y, rotation]
    for (i = [
        [0,w/-2,0],
        [0,w/2,-90],
        [d,w/-2,90],
        [d,w/2,180],
      ]) {
      translate([i[0], i[1], 0-$e])
      rotate([0, 0, i[2]])
      fillet(r=corner_radius,h=h+(2*$e),extra=$e);
    }

    // V slot
    for (i = [-1, 1]) {
    translate([offset, 0, 0])
    rotate([0,0, i*((max(90,angle)-90)/2) - 45])
      translate([0,0,-1*$e]) cube([2*w, 2*w, h + 2*$e]);
    }

    // Bolt Holes
    translate([0, 0, h/2])
    rotate([0, 90, 0]) {
      for (i = [-1, 1]) {
        translate([0, i * bolt_center/2, 0]) {
          hull() {
            scale([1, i, 1])
            translate([0, bolt_slot,0-$e]) cylinder(r=bolt_diameter/2, h=d+(2*$e));
            cylinder(r=bolt_diameter/2, h=d+(2*$e));
          };
        }
      }
    }

  }
}

vblock_pole_clamp();
