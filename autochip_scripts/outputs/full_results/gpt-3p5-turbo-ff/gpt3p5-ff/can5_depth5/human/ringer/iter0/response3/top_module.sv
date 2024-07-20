module top_module(
    input ring, 
    input vibrate_mode,
    output ringer,
    output motor
);

// Assign ringer and motor based on the input signals
assign ringer = vibrate_mode ? 0 : ring;
assign motor = vibrate_mode ? 1 : ~ring;

endmodule
