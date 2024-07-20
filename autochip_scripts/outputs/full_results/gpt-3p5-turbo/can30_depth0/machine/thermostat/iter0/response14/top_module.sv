module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    reg fan;
    assign fan = (too_cold || too_hot || fan_on) ? 1'b1 : 1'b0;

    reg heater;
    assign heater = (mode && too_cold) ? 1'b1 : 1'b0;

    reg aircon;
    assign aircon = (!mode && too_hot) ? 1'b1 : 1'b0;

endmodule
