use <util.scad>;
use <uhf_spacer.scad>;
use <vblock_pole_clamp.scad>;

width               = 35;       // Antenna mount width
height              = 20;       // Overall design thickness
connector_depth     = 18;       // depth of portion housing connector and wiring
antenna_id          = 16;       // Bore size for antenna connector
bolt_size           = 4.2;      // Clearance hole for connector bolts
fillet              = 2.5;      // Fillet corner radius
wire_diameter       = 4.75;     // Diameter of antenna wire
wire_x_offset       = 3;        // Offset position of antenna wire from center axis
wire_z_offset       = 1;        // Offset depth of antenna wire

mount_angle         = 120;      
mount_width         = 80;
mount_height        = 27;
mount_depth         = 12;
mount_min_thickness = 2;
min_bolt_center     = 48;
bolt_diameter       = 8;
bolt_slot           = 10;


module mount_ubolt() {
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
  vblock_pole_clamp(
    angle=mount_angle,
    h=mount_height,
    w=mount_width,
    d=mount_depth,
    offset=mount_min_thickness,
    bolt_center=min_bolt_center,
    bolt_diameter=bolt_diameter,
    bolt_slot=bolt_slot
  );

  //Fillet inside corners (if needed)
  if (mount_width > width) {
    fillet_radius = min( (width - mount_width)/2, fillet);
    for (i = [[-1, 180], [1, 90]]) {
      translate([0, i[0] * width/2, 0])
      rotate([0,0, i[1]])
      fillet(r=min(fillet, abs(width - mount_width)/2), h=min(height, connector_depth), extra=0);
    }
  }
}

mount_ubolt();
