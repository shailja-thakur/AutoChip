module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    assign heater = mode & too_cold;       // Turn on heater if in heating mode and it is too cold
    assign aircon = ~mode & too_hot;       // Turn on air conditioning if in cooling mode and it is too hot
    assign fan = fan_on | heater | aircon; // Turn on fan if requested, or if either heater or air conditioning is on

endmodule
