module top_module(
    input ring, 
    input vibrate_mode,
    output ringer,
    output motor
);

    // Assign statements to control the ringer and motor outputs
    assign ringer = ring & ~vibrate_mode;
    assign motor = ring & vibrate_mode;

endmodule
