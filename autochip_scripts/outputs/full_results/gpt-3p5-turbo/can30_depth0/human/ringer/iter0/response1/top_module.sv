module top_module(
    input ring,
    input vibrate_mode,
    output ringer,
    output motor
);

    assign ringer = (vibrate_mode == 0) ? 1 : 0;
    assign motor = (vibrate_mode == 1) ? 1 : 0;

endmodule
