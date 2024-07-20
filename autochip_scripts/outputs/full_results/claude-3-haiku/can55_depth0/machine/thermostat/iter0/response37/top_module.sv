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
    // Default values
    heater = 0;
    aircon = 0;
    fan = 0;

    // Fan control
    if (too_cold || too_hot || fan_on) begin
        fan = 1;
    end

    // Heating mode
    if (mode) begin
        if (too_cold) begin
            heater = 1;
        end
    end
    // Cooling mode
    else begin
        if (too_hot) begin
            aircon = 1;
        end
    end
end

endmodule
