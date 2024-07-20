module top_module(
    input ring, 
    input vibrate_mode,
    output ringer,
    output motor
);

    // Ringer is set to 1 when ring is 1 and vibrate_mode is 0
    assign ringer = ring & ~vibrate_mode;

    // Motor is set to 1 when both ring and vibrate_mode are 1
    assign motor = ring & vibrate_mode;

endmodule
