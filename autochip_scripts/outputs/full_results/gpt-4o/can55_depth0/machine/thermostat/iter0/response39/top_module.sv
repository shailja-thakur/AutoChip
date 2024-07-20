module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);
    // Assign the fan output
    assign fan = too_cold || too_hot || fan_on;

    // Assign the heater output
    assign heater = mode && too_cold;

    // Assign the aircon output
    assign aircon = !mode && too_hot;
endmodule
