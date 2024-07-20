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
    // Heater control logic
    if (mode == 1 && (too_cold || fan_on))
        heater = 1;
    else
        heater = 0;

    // Air conditioner control logic
    if (mode == 0 && (too_hot || fan_on))
        aircon = 1;
    else
        aircon = 0;

    // Fan control logic
    if (heater || aircon || fan_on)
        fan = 1;
    else
        fan = 0;
end

endmodule
