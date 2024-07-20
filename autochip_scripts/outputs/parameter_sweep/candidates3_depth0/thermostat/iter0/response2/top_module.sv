module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);
    
    // Internal signals
    wire fan_request;
    
    // Turn on heater when too_cold is asserted in heating mode
    assign heater = (mode == 1 && too_cold);
    
    // Turn on air conditioner when too_hot is asserted in cooling mode
    assign aircon = (mode == 0 && too_hot);
    
    // Turn on fan when either heater, air conditioner, or fan_on is asserted
    assign fan_request = heater || aircon || fan_on;
    assign fan = fan_request;
    
endmodule
