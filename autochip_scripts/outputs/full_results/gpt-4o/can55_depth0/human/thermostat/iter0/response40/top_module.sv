module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Heater is on only in heating mode and when it is too cold.
    assign heater = (mode == 1 && too_cold);

    // Air conditioner is on only in cooling mode and when it is too hot.
    assign aircon = (mode == 0 && too_hot);

    // Fan is on if either the heater or air conditioner is on, or if fan_on is requested.
    assign fan = heater || aircon || fan_on;

endmodule
