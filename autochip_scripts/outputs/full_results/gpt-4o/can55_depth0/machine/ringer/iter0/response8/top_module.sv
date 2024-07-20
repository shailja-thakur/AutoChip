module top_module(
    input ring,
    input vibrate_mode,
    output ringer,
    output motor
);

// Assign ringer based on ring and vibrate_mode signals
assign ringer = ring & ~vibrate_mode;

// Assign motor based on ring and vibrate_mode signals
assign motor = ring & vibrate_mode;

endmodule
