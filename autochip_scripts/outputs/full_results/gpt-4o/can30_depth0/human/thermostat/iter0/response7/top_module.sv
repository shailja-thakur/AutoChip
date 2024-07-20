module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Heater control: Only on in heating mode and when too_cold
    assign heater = mode & too_cold;

    // Air conditioner control: Only on in cooling mode and when too_hot
    assign aircon = ~mode & too_hot;

    // Fan control: On if either heater, aircon, or fan_on is on
    assign fan = heater | aircon | fan_on;

endmodule
