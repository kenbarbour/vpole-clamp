use <util.scad>;
use <uhf_spacer.scad>;
use <pole_clamp.scad>;

width = 35;                 // Overall design width
height = 20;                // Overall design height
connector_depth = 18;       // depth of portion housing connector and wiring
clamp_id = 23.25;           // Bore size of pole clamp
antenna_id = 16;            // Bore size for antenna connector
bolt_size = 4.2;            // Clearance hole for connector bolts
fillet = 5;                 // Fillet corner radius
wire_diameter = 4.75;       // Diameter of antenna wire
wire_x_offset = 3;          // Offset position of antenna wire from center axis
wire_z_offset = 1;          // Offset depth of antenna wire


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
  pole_clamp(id=clamp_id);
}

mount();
