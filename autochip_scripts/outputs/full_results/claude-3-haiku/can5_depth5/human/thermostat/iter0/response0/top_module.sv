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
        // Turn on heater if too_cold
        heater = too_cold;
        // Turn off air conditioner
        aircon = 0;
        // Turn on fan if heater or fan_on
        fan = heater | fan_on;
    end
    // In cooling mode
    else begin
        // Turn on air conditioner if too_hot
        aircon = too_hot;
        // Turn off heater
        heater = 0;
        // Turn on fan if air conditioner or fan_on
        fan = aircon | fan_on;
    end
end

endmodule
