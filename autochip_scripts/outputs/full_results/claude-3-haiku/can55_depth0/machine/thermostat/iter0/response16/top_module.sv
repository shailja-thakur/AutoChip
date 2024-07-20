module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output reg heater,
    output reg aircon,
    output reg fan
);

always @(*) begin
    // Control the fan
    fan = (too_cold || too_hot || fan_on);

    // Control the heater
    heater = (mode && too_cold);

    // Control the air conditioner
    aircon = (~mode && too_hot);
end

endmodule
