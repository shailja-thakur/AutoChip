module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);
    // Heater is on if in heating mode and it's too cold
    assign heater = mode & too_cold;
    
    // Air conditioner is on if in cooling mode and it's too hot
    assign aircon = ~mode & too_hot;
    
    // Fan is on if either heater is on, air conditioner is on, or fan_on is set
    assign fan = heater | aircon | fan_on;

endmodule
