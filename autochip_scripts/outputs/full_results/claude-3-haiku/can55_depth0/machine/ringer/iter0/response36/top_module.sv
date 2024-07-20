module top_module(
    input ring, 
    input vibrate_mode,
    output ringer,
    output motor
);

    // The ringer output is set to the logical AND of the ring input and the logical NOT of the vibrate_mode input
    assign ringer = ring & ~vibrate_mode;

    // The motor output is set to the logical AND of the ring input and the vibrate_mode input
    assign motor = ring & vibrate_mode;

endmodule
