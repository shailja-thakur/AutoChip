module top_module(
    input mode,         // 1 for heating, 0 for cooling
    input too_cold,     // 1 when the temperature is too cold
    input too_hot,      // 1 when the temperature is too hot
    input fan_on,       // 1 when the user wants to turn the fan on
    output reg heater,  // 1 to turn the heater on
    output reg aircon,  // 1 to turn the air conditioner on
    output reg fan      // 1 to turn the fan on
);

always @(*) begin
    // Initialize outputs to 0
    heater = 0;
    aircon = 0;
    fan = 0;
    
    if (mode) begin
        // Heating mode
        if (too_cold) begin
            heater = 1;
            fan = 1;
        end
    end else begin
        // Cooling mode
        if (too_hot) begin
            aircon = 1;
            fan = 1;
        end
    end
    
    // If the user requests the fan to be on, turn it on regardless
    if (fan_on) begin
        fan = 1;
    end
end

endmodule
