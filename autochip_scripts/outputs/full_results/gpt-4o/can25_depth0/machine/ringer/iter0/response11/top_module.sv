module top_module(
    input ring,
    input vibrate_mode,
    output ringer,
    output motor
);
    // Assign ringer to be high when ring is high and vibrate_mode is low
    assign ringer = ring & ~vibrate_mode;
    
    // Assign motor to be high when ring is high and vibrate_mode is high
    assign motor = ring & vibrate_mode;
endmodule
