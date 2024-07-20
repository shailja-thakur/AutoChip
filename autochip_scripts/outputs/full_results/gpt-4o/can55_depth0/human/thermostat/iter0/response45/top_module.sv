module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);
    
    // Heating mode: Mode = 1
    assign heater = (mode & too_cold);
    
    // Cooling mode: Mode = 0
    assign aircon = (~mode & too_hot);
    
    // Fan is on if heater or aircon is on, or if fan_on is requested
    assign fan = (heater | aircon | fan_on);
    
endmodule
