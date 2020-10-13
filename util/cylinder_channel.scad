module cylinder_channel(depth, diameter, length, x=0, y=0, z=0) {

    // Translate extruded shape on Z axis
    translate([0, 0, z]) {
        // Cutout
        linear_extrude(depth) {
            // Draw a hull around the two ends of the channel
            // to bore out the channel itself
            hull() {
                // Channel start - 'front'
                translate([x, y]) {
                    circle(d=diameter);
                }

                // Channel end - 'rear'
                translate([x + length, y]) {
                    circle(d=diameter);
                }
            }
        }
    }
}