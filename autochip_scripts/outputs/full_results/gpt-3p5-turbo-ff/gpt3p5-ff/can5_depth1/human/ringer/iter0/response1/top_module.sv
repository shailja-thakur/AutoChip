module top_module(
  input ring, 
  input vibrate_mode, 
  output ringer, 
  output motor
);
  
  assign ringer = ~vibrate_mode;
  assign motor = vibrate_mode;
  
endmodule
