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
    if (mode == 1'b1) begin
        // Turn on heater if too cold
        heater = too_cold;
        // Turn off air conditioner
        aircon = 1'b0;
        // Turn on fan if heater is on or if manually requested
        fan = too_cold | fan_on;
    end
    // In cooling mode
    else begin
        // Turn on air conditioner if too hot
        aircon = too_hot;
        // Turn off heater
        heater = 1'b0;
        // Turn on fan if air conditioner is on or if manually requested
        fan = too_hot | fan_on;
    end
end

endmodule
