module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Logic for controlling the fan
assign fan = (too_cold || too_hot || fan_on);

// Logic for controlling the heater
assign heater = (mode && too_cold);

// Logic for controlling the air conditioner
assign aircon = (!mode && too_hot);

endmodule
