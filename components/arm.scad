// Sur-Ron Rear Swingarm Arm (one side).
// Default dimensions measured from 2019 LBX (Off-Road) / drawings

def_pivot_diameter       = 22; // Bearing goes in here
def_pivot_outer_diameter = 30; // Guess, needs confirming for clearance
def_pivot_depth          = 17; // Measurement

// Guess, needs measuring later. This is the height between
// the midpoint of the pivot and the top of the midpoint 
// of the swingarm.
def_mid_offset_y         = 80;
def_mid_offset_x         = 149; // Guess, based on technical drawings
def_mid_height           = 70; // Guess
def_mid_depth            = 17; // Measurement, change based on req.
def_mid_length           = 10; // Guess, 1cm flat at 'midpoint'

def_rear_depth           = 15.7; // Must match dropout depth
def_rear_height          = 40; // Must match dropout height
def_rear_length          = 10;


// From technical drawings, this is the horizontal distance
// between the centre of the pivot point and the centre of
// the rear axle. We will need to adjust this based on the
// length of the dropout but for initial purposes, this will
// suffice.
def_length             = 458;

// From technical drawings, this is the drop between
// the center of the front pivot point and the rear axle.
// Since the rear axle is centered in the dropout, for 
// our purposes this is the drop between the centre 
// of the pivot point and the middle of the rear 'height'. 
def_drop               = 129; 


module SurRonArm(
    pivot_diameter=def_pivot_diameter,
    pivot_outer_diameter=def_pivot_outer_diameter,
    pivot_depth=def_pivot_depth,
    mid_height=def_mid_height,
    mid_offset_x=def_mid_offset_x,
    mid_offset_y=def_mid_offset_y,
    mid_depth=def_mid_depth,
    mid_length=def_mid_length,
    rear_depth=def_rear_depth,
    rear_height=def_rear_height,
    rear_length=def_rear_length,
    length=def_length,
    drop=def_drop,
){
    // Offset calculations
    mid_height_offset = mid_offset_y - mid_height;
    mid_rear_offset = mid_offset_x + (mid_length/2);

    rear_drop = - (drop+(rear_height/2));

    dropout_offset = length + rear_length;
    
    // End offset calculations

    difference() {
        union() {
            difference() {
                union() {
                    hull() {
                        // Pivot end swingarm outer
                        linear_extrude(pivot_depth) {
                            circle(d=pivot_outer_diameter);
                        }

                        // Midpoint - front
                        linear_extrude(mid_depth) {
                            translate([mid_offset_x, mid_height_offset]) {
                                square([mid_length/2, mid_height]);
                            }
                        }
                    }

                    hull() {
                        // Midpoint - rear
                        linear_extrude(mid_depth) {
                            translate([mid_rear_offset, mid_height_offset]) {
                                square([mid_length/2, mid_height]);
                            }
                        }

                        // Rear
                        linear_extrude(rear_depth) {
                            translate([length, rear_drop]) {
                                square([rear_length, rear_height]);
                            }
                        }
                    }
                }

                // Pivot end bearing hole
                linear_extrude(pivot_depth) {
                    circle(d=pivot_diameter);
                }
            }

            translate([dropout_offset, rear_drop]) {
                children(index=0);
            }
        }
        children(index=1);
    }
}