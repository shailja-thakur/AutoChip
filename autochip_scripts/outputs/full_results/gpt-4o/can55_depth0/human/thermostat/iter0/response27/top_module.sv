module top_module(
    input mode,           // 1 for heating, 0 for cooling
    input too_cold,       // 1 if it's too cold
    input too_hot,        // 1 if it's too hot
    input fan_on,         // 1 if the user requests the fan to be on
    output reg heater,    // Output to control the heater
    output reg aircon,    // Output to control the air conditioner
    output reg fan        // Output to control the fan
);

    always @(*) begin
        if (mode) begin // Heating mode
            if (too_cold) begin
                heater = 1;
                aircon = 0;
            end else begin
                heater = 0;
                aircon = 0;
            end
        end else begin // Cooling mode
            if (too_hot) begin
                heater = 0;
                aircon = 1;
            end else begin
                heater = 0;
                aircon = 0;
            end
        end
        
        // Fan logic: Fan turns on if either heater or aircon is on, or if user requests it
        if (heater || aircon || fan_on) begin
            fan = 1;
        end else begin
            fan = 0;
        end
    end

endmodule
