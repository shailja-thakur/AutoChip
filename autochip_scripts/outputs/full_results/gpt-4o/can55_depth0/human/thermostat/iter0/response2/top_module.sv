module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Heater logic: On when mode is heating and it's too cold
    assign heater = mode & too_cold;
    
    // Air Conditioner logic: On when mode is cooling and it's too hot
    assign aircon = ~mode & too_hot;
    
    // Fan logic: On when either heater or air conditioner is on, or user requests fan on
    assign fan = heater | aircon | fan_on;

endmodule
