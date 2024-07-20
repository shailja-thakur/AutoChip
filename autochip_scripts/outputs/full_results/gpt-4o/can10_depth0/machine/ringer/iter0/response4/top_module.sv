module top_module(
    input ring,
    input vibrate_mode,
    output ringer,
    output motor
);

    // Assign ringer output to the logical AND of ring and NOT of vibrate_mode
    assign ringer = ring & ~vibrate_mode;

    // Assign motor output to the logical AND of ring and vibrate_mode
    assign motor = ring & vibrate_mode;

endmodule
