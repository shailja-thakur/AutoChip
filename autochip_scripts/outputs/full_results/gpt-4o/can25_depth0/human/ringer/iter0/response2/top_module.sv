module top_module(
    input ring, 
    input vibrate_mode,
    output ringer,
    output motor
);
    // Ensure ringer and motor are off initially
    assign ringer = ring & ~vibrate_mode;
    assign motor = ring & vibrate_mode;

endmodule
