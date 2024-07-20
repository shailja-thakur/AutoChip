module top_module(
    input ring,
    input vibrate_mode,
    output ringer,
    output motor
);

    // Control the ringer - it's on when ring is 1 and vibrate_mode is 0
    assign ringer = ring & ~vibrate_mode;

    // Control the motor - it's on when both ring and vibrate_mode are 1
    assign motor = ring & vibrate_mode;

endmodule
