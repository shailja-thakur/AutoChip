module top_module(
    input ring,
    input vibrate_mode,
    output ringer,
    output motor
);

    assign ringer = ring & ~vibrate_mode;     // Control the ringer output based on the ring and vibrate_mode inputs
    assign motor = ring & vibrate_mode;        // Control the motor output based on the ring and vibrate_mode inputs

endmodule
