module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    assign heater = (mode == 1 && too_cold) || (fan_on && !too_hot);
    assign aircon = (mode == 0 && too_hot) || (fan_on && !too_cold);
    assign fan = (heater || aircon || fan_on);

endmodule
