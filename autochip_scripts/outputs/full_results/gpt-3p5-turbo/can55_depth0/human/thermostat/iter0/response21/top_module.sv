module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);
    wire fan_required;
    
    assign heater = (mode == 1) && too_cold;
    assign aircon = (mode == 0) && too_hot;
    
    assign fan_required = (fan_on || heater || aircon);
    assign fan = fan_required;
    
endmodule
