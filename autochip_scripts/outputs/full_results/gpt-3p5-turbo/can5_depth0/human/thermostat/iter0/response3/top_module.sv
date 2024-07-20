module top_module(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);
  
  reg fan_output;
  
  always @(*)
  begin
    fan_output = (fan_on || heater || aircon) ? 1'b1 : 1'b0;
    
    if (mode)
    begin
      heater = (too_cold && !fan_on) ? 1'b1 : 1'b0;
      aircon = 1'b0;
    end
    else
    begin
      heater = 1'b0;
      aircon = (too_hot && !fan_on) ? 1'b1 : 1'b0;
    end
  end
  
  assign fan = fan_output;

endmodule
