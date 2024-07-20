module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

  reg fan;

  // Control the fan
  always @* begin
    if (fan_on || too_cold || too_hot)
      fan = 1'b1;
    else
      fan = 1'b0;
  end

  // Control the heater
  assign heater = (mode && too_cold) ? 1'b1 : 1'b0;

  // Control the air conditioner
  assign aircon = (!mode && too_hot) ? 1'b1 : 1'b0;

endmodule
