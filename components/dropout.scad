include <../util/cylinder_channel.scad>
// Sur-Ron Rear Axle Dropout for Swingarm.
// Default dimensions measured from 2019 LBX (Off-Road)
def_dropout_depth         = 15.7;
def_dropout_height        = 40;
def_dropout_length        = 78;

def_axle_channel_length   = 38;
def_axle_channel_diameter = 12; // M12 Rear Axle

def_adj_channel_depth     = 9;
def_adj_channel_length    = 68;
def_adj_channel_height    = 28;

def_adj_bolt_diameter     = 6;  // M6x35 Adjuster Bolt
def_adj_bolt_length       = 35;

def_pad_depth             = 1;
def_pad_diameter          = def_axle_channel_diameter * 1.8;


module SurRonDropOut(
    depth=def_dropout_depth,
    height=def_dropout_height,
    length=def_dropout_length,
    channel_length=def_axle_channel_length,
    channel_diameter=def_axle_channel_diameter,
    adj_depth=def_adj_channel_depth,
    adj_length=def_adj_channel_length,
    adj_height=def_adj_channel_height,
    adj_bolt_diameter=def_adj_bolt_diameter,
    adj_bolt_length=def_adj_bolt_length,
    pad_depth=def_pad_depth,
    pad_diameter=def_pad_diameter
){
    // Offset calculations

    // Minkowski radius rounds the dropout corners
    // Adding rounded corners needs some other offsets adjusted.
    mink_radius = 0;

    // Center adjuster channel in the dropout based on lengths
    adj_channel_length_offset  = (length - adj_length) + mink_radius;
    adj_channel_height_offset  = (height - adj_height) / 2;

    // Center axle channel in the adjuster channel based on lengths
    axle_channel_length_offset = adj_channel_length_offset + (adj_length - channel_length) / 2;
    axle_channel_height_offset = height / 2; // Distance to center of channel circles

    // Center adj bolt in adjuster channel
    adj_bolt_depth_offset = adj_depth / 2;

    // End offset calculations

    difference() {
        // Add internal pad to dropout
        union() {
            // Pad
            cylinder_channel(
                pad_depth,
                pad_diameter,
                channel_length,
                x=axle_channel_length_offset,
                y=axle_channel_height_offset,
                z=depth
            );

            // Dropout
            // Build out dropout from a base 'block' of material which we subtract from
            difference() {
                // Base dropout material which we subtract from with difference()
                linear_extrude(depth) {
                    //minkowski() {
                        square([length, height]);
                      //  circle(r=mink_radius);
                    //}
                }

                // Adjuster cutout
                linear_extrude(adj_depth) {
                    translate([adj_channel_length_offset, adj_channel_height_offset, 0]) {
                        square([adj_length + mink_radius, adj_height]);
                    }
                }

            }
        }

        // Axle cutout
        cylinder_channel(
            depth + pad_depth,
            channel_diameter,
            channel_length,
            x=axle_channel_length_offset,
            y=axle_channel_height_offset,
            z=0
        );
    }
}