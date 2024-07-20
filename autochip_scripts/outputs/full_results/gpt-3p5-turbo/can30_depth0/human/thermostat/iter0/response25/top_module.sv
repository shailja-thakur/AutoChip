module top_module(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);

  reg heater_reg, aircon_reg, fan_reg;
  
  always @(*) begin
    if (mode == 1) begin // heating mode
      if (too_cold == 1) begin
        heater_reg = 1;
        aircon_reg = 0;
        fan_reg = 1;
      end else if (fan_on == 1) begin
        heater_reg = 0;
        aircon_reg = 0;
        fan_reg = 1;
      end else begin
        heater_reg = 0;
        aircon_reg = 0;
        fan_reg = 0;
      end
    end else if (mode == 0) begin // cooling mode
      if (too_hot == 1) begin
        aircon_reg = 1;
        heater_reg = 0;
        fan_reg = 1;
      end else if (fan_on == 1) begin
        aircon_reg = 0;
        heater_reg = 0;
        fan_reg = 1;
      end else begin
        heater_reg = 0;
        aircon_reg = 0;
        fan_reg = 0;
      end
    end
  end
  
  assign heater = heater_reg;
  assign aircon = aircon_reg;
  assign fan = fan_reg;

endmodule
