module top_module(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);
  
  reg heater;
  reg aircon;
  reg fan;

  always @(*)
  begin
    // Heating Mode
    if(mode == 1 && too_cold)
    begin
      heater = 1;
      aircon = 0;
      fan = 1;
    end
    // Cooling Mode
    else if(mode == 0 && too_hot)
    begin
      heater = 0;
      aircon = 1;
      fan = 1;
    end
    // Fan only mode
    else if(fan_on)
    begin
      heater = 0;
      aircon = 0;
      fan = 1;
    end
    // All off
    else
    begin
      heater = 0;
      aircon = 0;
      fan = 0;
    end
  end

  assign heater = heater;
  assign aircon = aircon;
  assign fan = fan;

endmodule
