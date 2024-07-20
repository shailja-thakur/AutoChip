module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);
    // Intermediate signals
    wire heat_on, cool_on;

    // Heater is on in heating mode only if it's too cold
    assign heat_on = mode && too_cold;

    // Air conditioner is on in cooling mode only if it's too hot
    assign cool_on = ~mode && too_hot;

    // Assigning outputs
    assign heater = heat_on;
    assign aircon = cool_on;
    assign fan = heat_on || cool_on || fan_on;

endmodule
