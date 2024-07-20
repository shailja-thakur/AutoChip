module top_module(
    input wire ring, 
    input wire vibrate_mode,
    output wire ringer,
    output wire motor
);

  assign ringer = (vibrate_mode == 1) ? 0 : ring;
  assign motor = (vibrate_mode == 1) ? ring : 0;

endmodule
