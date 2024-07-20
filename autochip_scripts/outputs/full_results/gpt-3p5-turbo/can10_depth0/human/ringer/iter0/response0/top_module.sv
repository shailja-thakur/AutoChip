module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);
 
    // Wire to control whether ringer or motor is on
    wire ringer_on;
    wire motor_on;
 
    // Assign the ringer_on wire based on vibrate_mode input
    assign ringer_on = (vibrate_mode == 1'b1) ? 1'b0 : 1'b1;
 
    // Assign the motor_on wire based on vibrate_mode input
    assign motor_on = vibrate_mode;
 
    // Assign the ringer and motor outputs based on the ring input and ringer_on/motor_on wires
    assign ringer = (ring == 1'b1) ? ringer_on : 1'b0;
    assign motor = (ring == 1'b1) ? 1'b0 : motor_on;
 
endmodule
