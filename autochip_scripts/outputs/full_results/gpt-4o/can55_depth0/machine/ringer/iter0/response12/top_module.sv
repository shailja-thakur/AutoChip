module top_module(
    input ring, 
    input vibrate_mode,
    output ringer,
    output motor
);

    // Assign ringer output to indicate ringing when ring is 1 and vibrate_mode is 0
    assign ringer = ring & ~vibrate_mode;
    
    // Assign motor output to indicate vibrating when ring is 1 and vibrate_mode is 1
    assign motor = ring & vibrate_mode;

endmodule
