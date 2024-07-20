module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);
    wire fan_on_output;

    assign heater = (mode && too_cold && !too_hot) || fan_on;
    assign aircon = (!mode && too_hot && !too_cold) || fan_on;
    assign fan = heater || aircon || fan_on;

endmodule
