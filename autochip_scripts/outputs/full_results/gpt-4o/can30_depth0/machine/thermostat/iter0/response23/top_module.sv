module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Control for the fan
    assign fan = fan_on | too_cold | too_hot;

    // Control for the heater
    assign heater = (mode & too_cold);
    
    // Control for the air conditioner
    assign aircon = (~mode & too_hot);

endmodule
