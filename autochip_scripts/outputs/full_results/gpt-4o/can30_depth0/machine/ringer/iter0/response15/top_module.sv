module top_module(
    input ring, 
    input vibrate_mode,
    output ringer,
    output motor
);

    // Assign the ringer output to ring AND NOT vibrate_mode
    assign ringer = ring & ~vibrate_mode;

    // Assign the motor output to ring AND vibrate_mode
    assign motor = ring & vibrate_mode;

endmodule
