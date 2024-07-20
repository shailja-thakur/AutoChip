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
    // Set the default values of the outputs
    heater = 1'b0;
    aircon = 1'b0;
    fan = 1'b0;

    // Determine the mode of operation
    if (mode) begin
        // Heating mode
        if (too_cold) begin
            // Room is too cold, turn on the heater
            heater = 1'b1;
        end
        // Turn on the fan if either too_cold or fan_on is high
        if (too_cold || fan_on) begin
            fan = 1'b1;
        end
    end else begin
        // Cooling mode
        if (too_hot) begin
            // Room is too hot, turn on the air conditioner
            aircon = 1'b1;
        end
        // Turn on the fan if either too_hot or fan_on is high
        if (too_hot || fan_on) begin
            fan = 1'b1;
        end
    end
end

endmodule
