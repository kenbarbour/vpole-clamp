use <util.scad>;
use <uhf_spacer.scad>;
use <pole_clamp.scad>;

width = 35;                 // Overall design width
connector_depth = 18;       // depth of portion housing connector and wiring
clamp_id = 23.25;           // Bore size of pole clamp
antenna_id = 16;            // Bore size for antenna connector
bolt_size = 4.2;            // Clearance hole for connector bolts


module mount() {
  translate([width/-2, 0, 0])
    uhf_spacer(
      size=[width, width, connector_depth],
      center_d=antenna_id,
      bolt_d=bolt_size
    );
  pole_clamp(id=clamp_id);
}

mount();
