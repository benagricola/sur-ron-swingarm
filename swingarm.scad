include <components/dropout.scad>
include <components/arm.scad>
include <components/adjuster.scad>

$fn=40;

adj_channel_depth = 9;
dropout_height    = 40;
drop              = 129;

SurRonArm(rear_height=dropout_height) {
    SurRonDropOut(height=dropout_height);
    SurRonAdjusterHole(
        height_offset=drop, 
        depth_offset=adj_channel_depth/2,
        length_offset=458 
    );
};