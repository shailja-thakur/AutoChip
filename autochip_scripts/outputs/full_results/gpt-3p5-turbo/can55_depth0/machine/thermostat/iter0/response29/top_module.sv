module top_module(
  input mode,
  input too_cold, 
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);
  // Declare internal wire for fan control
  wire fan_control;

  // Assign value to fan control wire
  assign fan_control = (fan_on || too_cold || too_hot);

  // Assign output values
  assign fan = fan_control;
  assign heater = (mode && too_cold);
  assign aircon = (!mode && too_hot);
endmodule
