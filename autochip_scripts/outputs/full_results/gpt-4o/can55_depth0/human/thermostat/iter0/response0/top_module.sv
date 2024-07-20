module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);
    // Initialize output signals
    assign heater = (mode && too_cold);         // Heater on in heating mode if too cold
    assign aircon = (!mode && too_hot);         // Air conditioner on in cooling mode if too hot
    assign fan    = fan_on || heater || aircon; // Fan on if fan_on is asserted or either heater or air conditioner is on

endmodule
