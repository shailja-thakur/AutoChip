module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    assign heater = mode & too_cold;            // Heater on if in heating mode and too cold
    assign aircon = ~mode & too_hot;            // Aircon on if in cooling mode and too hot
    assign fan = heater | aircon | fan_on;      // Fan on if either heater/aircon is on or user requests fan on

endmodule
