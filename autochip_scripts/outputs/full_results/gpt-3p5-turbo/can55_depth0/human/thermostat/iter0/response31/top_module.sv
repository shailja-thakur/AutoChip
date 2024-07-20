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
  wire fan;
  
  // Turn on heater if it is too cold and the mode is heating
  always @(mode, too_cold) begin
    if (mode && too_cold) begin
      heater <= 1;
    end
    else begin
      heater <= 0;
    end
  end
  
  // Turn on air conditioner if it is too hot and the mode is cooling
  always @(mode, too_hot) begin
    if (!mode && too_hot) begin
      aircon <= 1;
    end
    else begin
      aircon <= 0;
    end
  end
  
  // Turn on fan if any of the appliances are on or if fan is requested
  always @(heater, aircon, fan_on) begin
    if (heater || aircon || fan_on) begin
      fan <= 1;
    end
    else begin
      fan <= 0;
    end
  end
  
  assign fan = fan;
  
endmodule
