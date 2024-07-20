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
    // Default state: fan is off
    fan = 1'b0;

    // Heating mode
    if (mode == 1'b1) begin
        // Turn on heater if too cold
        heater = too_cold;
        // Turn off air conditioner
        aircon = 1'b0;
        // Turn on fan if heater or user requests it
        fan = heater | fan_on;
    end
    // Cooling mode
    else begin
        // Turn off heater
        heater = 1'b0;
        // Turn on air conditioner if too hot
        aircon = too_hot;
        // Turn on fan if air conditioner or user requests it
        fan = aircon | fan_on;
    end
end

endmodule
