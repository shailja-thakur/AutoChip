module top_module(
    input ring, 
    input vibrate_mode,
    output ringer,
    output motor
);

    // Assign ringer output to be 1 when ringing and not in vibrate mode
    assign ringer = ring & ~vibrate_mode;
    
    // Assign motor output to be 1 when ringing and in vibrate mode
    assign motor = ring & vibrate_mode;

endmodule
