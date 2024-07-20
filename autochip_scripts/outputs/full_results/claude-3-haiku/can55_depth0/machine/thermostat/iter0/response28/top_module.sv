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
    // Fan control
    fan = (too_cold || too_hot || fan_on);

    // Heater control
    heater = (mode && too_cold);

    // Air conditioner control
    aircon = (~mode && too_hot);
end

endmodule
