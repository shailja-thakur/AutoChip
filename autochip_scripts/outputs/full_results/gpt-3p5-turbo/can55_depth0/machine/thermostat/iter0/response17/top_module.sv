module top_module(
    input mode,
    input fan_on,
    input too_cold,
    input too_hot,
    output heater,
    output aircon,
    output fan
);

    // Fan control logic
    assign fan = fan_on || too_cold || too_hot;

    // Heater control logic
    assign heater = mode && too_cold;

    // Air conditioner control logic
    assign aircon = !mode && too_hot;

endmodule
