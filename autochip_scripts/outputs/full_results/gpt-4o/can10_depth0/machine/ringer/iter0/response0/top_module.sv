module top_module(
    input ring,
    input vibrate_mode,
    output ringer,
    output motor
);
    // Assign the ringer output to be 1 when ring is 1 and vibrate_mode is 0
    assign ringer = ring & ~vibrate_mode;

    // Assign the motor output to be 1 when ring is 1 and vibrate_mode is 1
    assign motor = ring & vibrate_mode;
endmodule
