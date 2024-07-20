module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);
    
    // Heater Control
    assign heater = mode & too_cold;
    
    // Air Conditioner Control
    assign aircon = ~mode & too_hot;
    
    // Fan Control
    assign fan = too_cold | too_hot | fan_on;

endmodule
