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
    // In heating mode
    if (mode == 1) begin
        // Turn on the heater if it's too cold
        heater = too_cold;
        // Don't turn on the air conditioner
        aircon = 0;
    end
    // In cooling mode
    else begin
        // Turn on the air conditioner if it's too hot
        aircon = too_hot;
        // Don't turn on the heater
        heater = 0;
    end

    // Turn on the fan if the heater or air conditioner is on, or if the user requests it
    fan = heater || aircon || fan_on;
end

endmodule
