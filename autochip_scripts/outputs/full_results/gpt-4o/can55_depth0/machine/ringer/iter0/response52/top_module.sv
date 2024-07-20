module top_module(
    input wire ring, 
    input wire vibrate_mode,
    output wire ringer,
    output wire motor
);

    // Control the ringer output: Ring when ring is high and vibrate_mode is low
    assign ringer = ring & ~vibrate_mode;

    // Control the motor output: Vibrate when both ring and vibrate_mode are high
    assign motor = ring & vibrate_mode;

endmodule
