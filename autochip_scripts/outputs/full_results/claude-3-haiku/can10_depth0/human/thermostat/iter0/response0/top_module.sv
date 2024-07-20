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
    // Default state
    heater = 0;
    aircon = 0;
    fan = 0;

    // Heating mode
    if (mode) begin
        if (too_cold) begin
            heater = 1;
            fan = 1;
        end
    end
    // Cooling mode
    else begin
        if (too_hot) begin
            aircon = 1;
            fan = 1;
        end
    end

    // User requested fan
    if (fan_on) begin
        fan = 1;
    end
end

endmodule
