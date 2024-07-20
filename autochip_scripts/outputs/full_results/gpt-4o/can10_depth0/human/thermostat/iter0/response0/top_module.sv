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
    if (mode) begin // Heating mode
        heater = too_cold; // Turn on heater if too cold
        aircon = 0; // Air conditioner is off
    end else begin // Cooling mode
        heater = 0; // Heater is off
        aircon = too_hot; // Turn on air conditioner if too hot
    end
    fan = heater | aircon | fan_on; // Turn on fan if heater or air conditioner is on, or if fan_on is requested
end

endmodule
