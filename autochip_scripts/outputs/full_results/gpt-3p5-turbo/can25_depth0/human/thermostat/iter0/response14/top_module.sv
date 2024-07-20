module top_module(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);
   // Declare internal wire signals
   wire heat_on, cool_on;
   
   // Logic to determine whether to turn on the heater
   assign heat_on = (mode == 1) && (too_cold == 1);
   assign heater = heat_on || fan_on;
   assign fan = heater;
   
   // Logic to determine whether to turn on the air conditioner
   assign cool_on = (mode == 0) && (too_hot == 1);
   assign aircon = cool_on || fan_on;

endmodule
