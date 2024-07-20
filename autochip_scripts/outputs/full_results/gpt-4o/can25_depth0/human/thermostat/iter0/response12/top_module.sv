module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Heater control: only active in heating mode when too cold
    assign heater = mode & too_cold;
    
    // Air conditioner control: only active in cooling mode when too hot
    assign aircon = ~mode & too_hot;
    
    // Fan control: active when heater or air conditioner is on, or when the user requests
    assign fan = (heater | aircon | fan_on);

endmodule
