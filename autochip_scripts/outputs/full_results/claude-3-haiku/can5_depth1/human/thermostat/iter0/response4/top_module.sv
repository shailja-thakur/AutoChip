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
    // Default state: turn off everything
    heater = 0;
    aircon = 0;
    fan = 0;

    // Heating mode
    if (mode == 1) begin
        // Turn on heater if it's too cold
        if (too_cold) begin
            heater = 1;
            fan = 1;
        end
    end
    // Cooling mode
    else begin
        // Turn on air conditioner if it's too hot
        if (too_hot) begin
            aircon = 1;
            fan = 1;
        end
    end

    // Turn on fan if requested by user
    if (fan_on) begin
        fan = 1;
    end
end

endmodule
