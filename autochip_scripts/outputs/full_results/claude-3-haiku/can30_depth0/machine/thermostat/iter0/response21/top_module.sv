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
    heater = 1'b0;
    aircon = 1'b0;
    fan = 1'b0;

    // Control logic
    if (mode) begin // Heating mode
        if (too_cold) begin
            heater = 1'b1;
            fan = 1'b1;
        end
    end else begin // Cooling mode
        if (too_hot) begin
            aircon = 1'b1;
            fan = 1'b1;
        end
    end

    // Fan override
    if (fan_on) begin
        fan = 1'b1;
    end
end

endmodule
