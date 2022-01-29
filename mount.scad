use <util.scad>;
use <uhf_spacer.scad>;
use <pole_clamp.scad>;

width = 35;                 // Antenna mount width
height = 20;                // Overall design thickness
connector_depth = 18;       // depth of portion housing connector and wiring
antenna_id = 16;            // Bore size for antenna connector
bolt_size = 4.2;            // Clearance hole for connector bolts
fillet = 5;                 // Fillet corner radius
wire_diameter = 4.75;       // Diameter of antenna wire
wire_x_offset = 3;          // Offset position of antenna wire from center axis
wire_z_offset = 1;          // Offset depth of antenna wire

clamp_id = 24;              // Bore size of pole clamp
clamp_width = 35;           // Clamp mount width
clamp_bolt_y_offset = 0;    // Offset from bore for bolt hole
clamp_nut_x_offset = 1;     // Offset from far end to place captive nut
clamp_slot = 3;             // Width of slot
clamp_is_split = 0;         // If true (1), a two-piece clamp will be produced

module mount() {
  difference() {
  translate([width/-2, 0, 0])
    uhf_spacer(
      size=[width, width, connector_depth],
      center_d=antenna_id,
      bolt_d=bolt_size
    );

    // Wire Grooves
    translate([
      width/-2 + wire_x_offset,
      0,
      connector_depth - wire_diameter + wire_z_offset])
    rotate([0, 0, -90])
      vpole_groove(
        wire_diameter,
        width*width,
        angle=120
      );

    // Fillet front corners
    for (i = [-1, 1]) {
      translate([0-width, i*width/2, -0.5])
      scale([1, -1*i, 1])
      fillet(r=fillet, h=height, extra=1);
    }
  }
  pole_clamp(
    w=clamp_width,
    h=height,
    id=clamp_id,
    slot=clamp_slot,
    bolt_y_offset=clamp_bolt_y_offset,
    nut_x_offset=clamp_nut_x_offset,
    is_split=clamp_is_split
  );

  //Fillet inside corners (if needed)
  if (clamp_width > width) {
    fillet_radius = min( (width - clamp_width)/2, fillet);
    for (i = [[-1, 180], [1, 90]]) {
      translate([0, i[0] * width/2, 0])
      rotate([0,0, i[1]])
      fillet(r=min(fillet, abs(width - clamp_width)/2), h=min(height, connector_depth), extra=0);
    }
  }
}

mount();
