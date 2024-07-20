module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output wire heater,
    output wire aircon,
    output wire fan
);

    // If either too_cold or too_hot is high, or if fan_on is high, turn on the fan
    assign fan = (too_cold || too_hot || fan_on);

    // If mode is high and too_cold is high, turn on the heater
    assign heater = (mode && too_cold);

    // If mode is low and too_hot is high, turn on the air conditioner
    assign aircon = (!mode && too_hot);

endmodule
