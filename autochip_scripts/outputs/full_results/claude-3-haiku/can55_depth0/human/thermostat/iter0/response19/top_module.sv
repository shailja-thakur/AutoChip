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

    // Heating mode
    if (mode == 1'b1) begin
        if (too_cold == 1'b1) begin
            heater = 1'b1;
            fan = 1'b1;
        end
    end
    // Cooling mode
    else if (mode == 1'b0) begin
        if (too_hot == 1'b1) begin
            aircon = 1'b1;
            fan = 1'b1;
        end
    end

    // Fan-only mode
    if (fan_on == 1'b1) begin
        fan = 1'b1;
    end
end

endmodule
