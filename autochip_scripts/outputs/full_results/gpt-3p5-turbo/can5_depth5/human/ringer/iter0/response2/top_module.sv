module top_module(
    input ring,
    input vibrate_mode,
    output ringer,
    output motor
);
    assign motor = vibrate_mode ? 1'b1 : 1'b0;
    assign ringer = vibrate_mode ? 1'b0 : 1'b1;
endmodule
