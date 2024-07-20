module top_module(
    input ring, 
    input vibrate_mode,
    output ringer,
    output motor
);

    // Assign the ringer output to the logical AND of ring and the logical NOT of vibrate_mode
    assign ringer = ring & ~vibrate_mode;
    
    // Assign the motor output to the logical AND of ring and vibrate_mode
    assign motor = ring & vibrate_mode;

endmodule
