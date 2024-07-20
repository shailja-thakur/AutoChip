module top_module(
    input ring, 
    input vibrate_mode,
    output ringer,
    output motor
);

    // Control the ringer output based on ring and vibrate_mode inputs
    assign ringer = ring & ~vibrate_mode;
    
    // Control the motor output based on ring and vibrate_mode inputs
    assign motor = ring & vibrate_mode;

endmodule
