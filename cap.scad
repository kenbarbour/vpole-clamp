use <uhf_spacer.scad>
use <util.scad>

/**
 * This cap is designed to hold antenna elements
 * and cover the UHF connector and wiring.
 * The thickness of this cap is chosen to work with
 * a 30mm long M3 bolt
 *
 * Cap + Spacer + Connector Flange + Washer + Nut < 30
 *  6     18               3           1       4  = 
 */
module cap(
  size=[35, 35, 10],
  bolt_spacing=17.5,
  bolt_d=4.2,
  wire_d=2.5,
  angle=120,
  center_offset=1.5,
  counterbore_depth=5,
  counterbore_diameter=8,
  rear_clearance=1,
  front_fillet=5,
  $e=1
) {

  difference() {
    uhf_spacer(
      size=size,
      center_d=0,
      bolt_spacing=bolt_spacing,
      bolt_d=bolt_d,
      cb_depth=counterbore_depth,
      cb_diameter=counterbore_diameter
    );
    
    // Groove for antenna wire
    extra_long=pow(size[0], 2);
    translate([0, center_offset, 0]) {
      for (i = [-1, 1]) {
        translate([0, 0, wire_d/2])
        rotate([0,0,-i*angle*0.5])
        rotate([90, 0, 0]) {
          cylinder(r=wire_d/2, h=extra_long);
          translate([0,wire_d/-2,extra_long/2])
            cube([wire_d, wire_d, extra_long], center=true);
        }
      }
      translate([0, 0, 0-$e])
        cylinder(r=wire_d, h=wire_d+$e);
    }

    // Fillet front corners
    for (i = [-1, 1]) {
      translate([i*size[0]/2, size[1]/-2, 0-$e])
      scale([-1*i, 1, 1])
      fillet(r=front_fillet, h=size[2]+(2*$e), extra=2*$e);
    }

    // Rear clearance
    translate([0, size[1]/2 - rear_clearance/2 + $e/2, size[2]/2])
      cube([size[0]+(2*$e), rear_clearance + $e, size[2] + 2], center=true);
  }
}

cap($fn=25);
