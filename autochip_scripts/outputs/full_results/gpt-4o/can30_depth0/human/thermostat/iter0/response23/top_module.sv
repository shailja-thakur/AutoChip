module top_module(
    input mode,        // 1: Heating, 0: Cooling
    input too_cold,    // 1: Too cold, 0: Not too cold
    input too_hot,     // 1: Too hot, 0: Not too hot
    input fan_on,      // 1: User requests fan on, 0: User does not request fan
    output reg heater, // Output to control heater
    output reg aircon, // Output to control air conditioner
    output reg fan     // Output to control fan
);

    always @(*) begin
        if (mode == 1) begin  // Heating mode
            heater = too_cold;  // Turn on heater if too cold
            aircon = 0;  // Turn off air conditioner
        end else begin  // Cooling mode
            heater = 0;  // Turn off heater
            aircon = too_hot;  // Turn on air conditioner if too hot
        end

        // Fan logic: on if either heater or aircon is on, or user requests fan on
        fan = heater || aircon || fan_on;
    end

endmodule
