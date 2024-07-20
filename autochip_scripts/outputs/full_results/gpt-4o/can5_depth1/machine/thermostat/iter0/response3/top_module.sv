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
    // Default outputs
    heater = 0;
    aircon = 0;
    fan = 0;

    // Control fan
    if (fan_on || too_cold || too_hot) begin
        fan = 1;
    end

    // Control heater and air conditioner
    if (mode) begin
        // Heating mode
        if (too_cold) begin
            heater = 1;
        end
    end else begin
        // Cooling mode
        if (too_hot) begin
            aircon = 1;
        end
    end
end

endmodule
