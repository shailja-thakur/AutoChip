module top_module(
    input ring,
    input vibrate_mode,
    output ringer,
    output motor
);

    // Control the ringer output: set to 1 if ring is 1 and vibrate_mode is 0, else 0.
    assign ringer = ring & ~vibrate_mode;

    // Control the motor output: set to 1 if both ring and vibrate_mode are 1, else 0.
    assign motor = ring & vibrate_mode;

endmodule
