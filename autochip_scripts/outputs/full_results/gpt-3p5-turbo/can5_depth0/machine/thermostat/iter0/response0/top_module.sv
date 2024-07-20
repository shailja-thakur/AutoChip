module top_module(
  input mode,
  input too_cold, 
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);

// Declare internal signal to determine if fan should be turned on
reg fan_on_internal;

// Determine if fan should be turned on
always @*
begin
  if (fan_on || too_cold || too_hot)
    fan_on_internal = 1;
  else
    fan_on_internal = 0;
end

// Control the fan output
assign fan = fan_on_internal;

// Control the heater output
assign heater = (mode && too_cold);

// Control the aircon output
assign aircon = (!mode && too_hot);

endmodule
