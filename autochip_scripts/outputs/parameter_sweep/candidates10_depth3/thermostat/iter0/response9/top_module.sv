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
    wire heater_on;
    wire aircon_on;
    
    // Turn on heater when it is too cold and in heating mode
    assign heater_on = (mode == 1) && too_cold;
    assign heater = heater_on;
    
    // Turn on air conditioner when it is too hot and in cooling mode
    assign aircon_on = (mode == 0) && too_hot;
    assign aircon = aircon_on;
    
    // Turn on fan when either heater, air conditioner, or fan is requested
    assign fan = fan_on || heater_on || aircon_on;
endmodule
