module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

   reg fan_on_request = 0;

   always @ (mode or fan_on) begin
      if (mode == 1 || fan_on == 1)
         fan_on_request = 1;
      else
         fan_on_request = 0;
   end

   always @ (mode or too_cold) begin
      if (mode == 1 && too_cold == 1)
         heater = 1;
      else
         heater = 0;
   end

   always @ (mode or too_hot) begin
      if (mode == 0 && too_hot == 1)
         aircon = 1;
      else
         aircon = 0;
   end

   always @ (fan_on_request or heater or aircon) begin
      if (fan_on_request == 1 || heater == 1 || aircon == 1)
         fan = 1;
      else
         fan = 0;
   end

endmodule
