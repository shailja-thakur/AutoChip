module top_module(
    input ring,
    input vibrate_mode,
    output ringer,
    output motor
);

    // Use assign statements to determine the values of ringer and motor outputs

    assign ringer = (vibrate_mode == 1) ? 0 : ring;
    assign motor = (vibrate_mode == 1) ? 1 : 0;

endmodule
