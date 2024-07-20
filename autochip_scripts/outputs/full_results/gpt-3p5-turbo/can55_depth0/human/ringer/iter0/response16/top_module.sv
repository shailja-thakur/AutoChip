module top_module(
    input ring,
    input vibrate_mode,
    output ringer,
    output motor
);
  
  assign ringer = (vibrate_mode == 1) ? 0 : ring;
  assign motor = (vibrate_mode == 1) ? 1 : ring;
  
endmodule
