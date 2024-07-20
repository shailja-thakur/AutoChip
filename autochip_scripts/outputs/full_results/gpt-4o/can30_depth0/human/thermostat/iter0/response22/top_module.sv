module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Heater control in heating mode
    assign heater = (mode == 1'b1) && (too_cold == 1'b1);

    // Air conditioner control in cooling mode
    assign aircon = (mode == 1'b0) && (too_hot == 1'b1);

    // Fan control: on if either heater or air conditioner is on, or if fan_on is requested
    assign fan = heater || aircon || fan_on;

endmodule
