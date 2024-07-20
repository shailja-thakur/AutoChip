module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);
    // Control heater and air conditioner based on mode and temperature inputs
    assign heater = (mode && too_cold);
    assign aircon = (!mode && too_hot);
    
    // Control fan based on heater, air conditioner, and user request
    assign fan = heater || aircon || fan_on;

endmodule
