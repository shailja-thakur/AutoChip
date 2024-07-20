module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Heater control: Turn on if mode is heating (mode is high) and it's too cold
    assign heater = mode & too_cold;
    
    // Air conditioner control: Turn on if mode is cooling (mode is low) and it's too hot
    assign aircon = ~mode & too_hot;
    
    // Fan control: Turn on if it's too cold, too hot or fan_on is high
    assign fan = too_cold | too_hot | fan_on;

endmodule
