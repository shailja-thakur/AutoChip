module top_module(
  input ring,
  input vibrate_mode,
  output ringer,
  output motor
);

  // The ringer output is set to 1 when the ring input is 1 and the vibrate_mode input is 0
  // It is set to 0 otherwise
  assign ringer = ring & ~vibrate_mode;
  
  // The motor output is set to 1 when both the ring input and the vibrate_mode input are 1
  // It is set to 0 otherwise
  assign motor = ring & vibrate_mode;

endmodule
