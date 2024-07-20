module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);
    // Declare internal signals
    wire temp_control;
    wire blower_control;
  
    // Temperature control logic
    assign temp_control = (mode && too_cold) || (!mode && too_hot);
  
    // Blower control logic
    assign blower_control = (heater || aircon || fan_on);
  
    // Output assignments
    assign heater = (mode && too_cold);
    assign aircon = (!mode && too_hot);
    assign fan = blower_control;
  
endmodule
