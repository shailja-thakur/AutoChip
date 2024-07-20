module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Heater control: Turn on if in heating mode and too cold
    assign heater = (mode && too_cold);

    // Air conditioner control: Turn on if in cooling mode and too hot
    assign aircon = (!mode && too_hot);

    // Fan control: Turn on if fan_on is set, or if either the heater or air conditioner is on
    assign fan = fan_on || heater || aircon;
    
endmodule
