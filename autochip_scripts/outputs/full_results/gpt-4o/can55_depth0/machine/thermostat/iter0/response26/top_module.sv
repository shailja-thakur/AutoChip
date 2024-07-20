module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Control logic for heater
    assign heater = (mode && too_cold) ? 1 : 0;

    // Control logic for air conditioner
    assign aircon = (!mode && too_hot) ? 1 : 0;

    // Control logic for fan
    assign fan = (too_cold || too_hot || fan_on) ? 1 : 0;

endmodule
