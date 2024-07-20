module top_module(
    input ring, 
    input vibrate_mode,
    output ringer,
    output motor
);
    // Assign ringer output based on the conditions described
    assign ringer = ring & ~vibrate_mode;

    // Assign motor output based on the conditions described
    assign motor = ring & vibrate_mode;

endmodule
