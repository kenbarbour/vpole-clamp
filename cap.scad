use <uhf_spacer.scad>

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
  size=[40, 40, 10],
  bolt_spacing=17.5,
  bolt_d=3.5,
  wire_d=1.5,
  angle=120,
  counterbore_depth=4,
  counterbore_diameter=6
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

    for (i = [-1, 1]) {
      rotate([0,0,-i*angle*0.5])
      rotate([90, 0, 0]) {
        cylinder(r=wire_d/2, h=pow(size[0], 2));
      }
    }
    cylinder(r=wire_d, h=wire_d/2);
  }
}

cap($fn=16);
