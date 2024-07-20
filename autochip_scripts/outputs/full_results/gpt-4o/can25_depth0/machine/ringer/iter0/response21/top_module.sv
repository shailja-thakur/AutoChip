module top_module(
    input ring,
    input vibrate_mode,
    output ringer,
    output motor
);

    // Set the ringer output
    assign ringer = ring & ~vibrate_mode;

    // Set the motor output
    assign motor = ring & vibrate_mode;

endmodule
