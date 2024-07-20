module top_module(
    input ring, 
    input vibrate_mode,
    output ringer,
    output motor
);

    assign ringer = ring & ~vibrate_mode; // Ringer should be on when ring is 1 and vibrate_mode is 0
    assign motor = ring & vibrate_mode;   // Motor should be on when ring is 1 and vibrate_mode is 1

endmodule
