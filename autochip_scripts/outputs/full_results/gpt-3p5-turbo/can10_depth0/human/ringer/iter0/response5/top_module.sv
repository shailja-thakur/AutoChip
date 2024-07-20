module top_module(
    input ring, 
    input vibrate_mode,
    output ringer,
    output motor
);

// Assign the ringer output based on vibrate_mode input
assign ringer = (vibrate_mode) ? 0 : 1;

// Assign the motor output based on the ring input and vibrate_mode input
assign motor = (vibrate_mode) ? 1 : ring;

endmodule
