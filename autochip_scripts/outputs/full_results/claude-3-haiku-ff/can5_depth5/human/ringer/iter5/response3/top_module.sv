module top_module(
    input ring, 
    input vibrate_mode,
    output ringer,
    output motor
);

assign ringer = vibrate_mode ? 0 : ring;
assign motor = vibrate_mode ? 1 : (ring ? 0 : 1);

endmodule
