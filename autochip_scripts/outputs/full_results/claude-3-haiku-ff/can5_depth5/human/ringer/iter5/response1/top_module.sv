module top_module(
    input ring, 
    input vibrate_mode,
    output ringer,
    output motor
);

assign ringer = vibrate_mode ? 1'b0 : ring;
assign motor = vibrate_mode ? 1'b1 : ~ring;

endmodule
