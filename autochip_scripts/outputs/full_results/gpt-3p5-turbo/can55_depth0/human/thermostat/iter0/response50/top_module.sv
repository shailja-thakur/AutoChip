module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Declare internal signal to control fan
    wire fan_control;
  
    // Generate fan control signal
    assign fan_control = (fan_on || (mode && too_cold) || (!mode && too_hot));
  
    // heater control logic
    assign heater = (mode && too_cold && !fan_on);
  
    // air conditioner control logic
    assign aircon = (!mode && too_hot && !fan_on);
  
    // fan control output
    assign fan = fan_control;
  
endmodule
