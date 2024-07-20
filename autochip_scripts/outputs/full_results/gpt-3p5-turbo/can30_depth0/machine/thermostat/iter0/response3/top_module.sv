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
    // Turn on heater if mode is high and room is too cold
    if (mode && too_cold)
        heater = 1;
    else
        heater = 0;

    // Turn on aircon if mode is low and room is too hot
    if (!mode && too_hot)
        aircon = 1;
    else
        aircon = 0;

    // Turn on fan if fan_on is high or room is too cold or too hot
    if (fan_on || too_cold || too_hot)
        fan = 1;
    else
        fan = 0;
end

endmodule
