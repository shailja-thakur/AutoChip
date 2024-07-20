module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // assign the outputs based on the inputs and conditions
    assign heater = (mode == 1) && too_cold;
    assign aircon = (mode == 0) && too_hot;
    assign fan = fan_on || heater || aircon;

endmodule
