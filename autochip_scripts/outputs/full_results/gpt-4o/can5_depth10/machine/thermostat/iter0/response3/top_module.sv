module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Control logic for the heater
    assign heater = mode && too_cold;

    // Control logic for the air conditioner
    assign aircon = ~mode && too_hot;

    // Control logic for the fan
    assign fan = too_cold || too_hot || fan_on;

endmodule
