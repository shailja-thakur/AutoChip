module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Temperature thresholds for heating and cooling
    localparam MIN_TEMPERATURE = 60;
    localparam MAX_TEMPERATURE = 80;

    // Logic for controlling the heater, aircon, and fan
    assign heater = (mode && too_cold && !too_hot) || fan_on;
    assign aircon = (!mode && too_hot && !too_cold) || fan_on;
    assign fan = heater || aircon || fan_on;

endmodule
