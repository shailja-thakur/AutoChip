module top_module(
    input ring,
    input vibrate_mode,
    output ringer,
    output motor
);

// Assigning the ringer and motor outputs based on the input conditions
assign ringer = (vibrate_mode == 1) ? 0 : ring;
assign motor = (vibrate_mode == 1) ? 1 : 0;

endmodule
