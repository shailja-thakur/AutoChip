module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Temperature control logic
assign fan = fan_on || too_cold || too_hot;
assign heater = (mode && too_cold);
assign aircon = (!mode && too_hot);

endmodule
