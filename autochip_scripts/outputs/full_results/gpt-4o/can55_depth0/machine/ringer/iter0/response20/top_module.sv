module top_module(
    input ring, 
    input vibrate_mode,
    output ringer,
    output motor
);

    // Ringer output is high when ring is high and vibrate_mode is low
    assign ringer = ring & ~vibrate_mode;

    // Motor output is high when both ring and vibrate_mode are high
    assign motor = ring & vibrate_mode;

endmodule
