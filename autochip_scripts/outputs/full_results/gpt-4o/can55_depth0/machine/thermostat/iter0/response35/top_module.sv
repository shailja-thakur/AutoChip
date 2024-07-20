module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Heater is on if mode is heating and it's too cold
    assign heater = mode & too_cold;
    
    // Air conditioner is on if mode is cooling and it's too hot
    assign aircon = ~mode & too_hot;
    
    // Fan is on if it's too hot, too cold, or fan_on is high
    assign fan = too_cold | too_hot | fan_on;

endmodule
