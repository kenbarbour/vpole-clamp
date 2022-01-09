use <util.scad>;
use <uhf_spacer.scad>;
use <pole_clamp.scad>;

module mount() {
  translate([-35/2, 0, 0])
    uhf_spacer(
      size=[35, 35, 18]
    );
  pole_clamp();
}

mount();
