def_adj_bolt_diameter     = 6;  // M6x35 Adjuster Bolt
def_adj_bolt_length       = 35;

module SurRonAdjusterHole(
    length=def_adj_bolt_length,
    diameter=def_adj_bolt_diameter,
    height_offset,
    depth_offset,
    length_offset
) {
    // Adjuster bolt hole
    translate([length_offset, -height_offset, depth_offset]) {
    rotate([0, 90, 0]) {
        linear_extrude(length) {
                circle(d=diameter);
            }
        }
    }
}
