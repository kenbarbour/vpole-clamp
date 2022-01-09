use <util.scad>

module pole_clamp(
  id=23,
  h=27,
  w=40,
  slot=3,
  bolt_d=6.5,
  bolt_z_offset=0,   // distance off-center
  bolt_y_offset=0,   // distance off-tangent of main bore
  bolt_hex=11.5,     // wrench size for hex-nut
  bolt_hex_height=6, // thickness of hex-nut
  nut_x_offset=1,    // x-position of captive hex-nut
  $e=1
) {
  difference() {

    // Main cube
    translate([0, w/-2, 0])
      cube([w, w, h]);

    // Bore a center hole
    translate([w/2,0,0-$e])
      cylinder(r=id/2,h=30+(2*$e));

    // Create a slot
    translate([(w-slot)/2, -1*w, 0-$e])
      cube([slot, w, h+(2*$e)]);

    // Clamp bolt hole
    translate([0, id/-2 - bolt_y_offset, h/2 + bolt_z_offset])
    rotate([0, 90, 0])
      cylinder(r=bolt_d/2, h=w+$e);

    // Captive clamp nut
    nut_diameter=bolt_hex / (sqrt(3)/2);
    translate([nut_x_offset, id/-2 - bolt_y_offset, h/2 + bolt_z_offset])
    rotate([90, 0, 90])
    union() {
      cylinder(r=nut_diameter/2, h=bolt_hex_height, $fn=6);
      translate([0-w, bolt_hex/-2, 0])
      cube([w, bolt_hex, bolt_hex_height]);
    }

    // Fillet
    translate([w+$e, w/2+$e, 0-$e])
    rotate([0,0, 180])
      fillet(r=w/2, h=h+(2*$e));
  }

}

pole_clamp();
