use <util.scad>;
use <uhf_spacer.scad>;
use <pole_clamp.scad>;

module mount() {
  translate([-20, 0, 0])
    uhf_spacer(
      size=[40, 40, 18]
    );
  pole_clamp();
}

mount();
