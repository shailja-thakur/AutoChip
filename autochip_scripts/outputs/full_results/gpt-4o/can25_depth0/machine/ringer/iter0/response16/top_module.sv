module top_module(
    input ring, 
    input vibrate_mode,
    output ringer,
    output motor
);

    // Assign ringer to be active when ring is active and vibrate_mode is inactive
    assign ringer = ring & ~vibrate_mode;

    // Assign motor to be active when both ring and vibrate_mode are active
    assign motor = ring & vibrate_mode;

endmodule
