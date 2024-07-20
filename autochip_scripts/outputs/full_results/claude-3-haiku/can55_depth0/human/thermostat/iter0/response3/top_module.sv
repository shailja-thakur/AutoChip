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
    // Default state: fan off, heater off, aircon off
    heater = 1'b0;
    aircon = 1'b0;
    fan = 1'b0;

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

    // User requested fan
    if (fan_on == 1'b1) begin
        fan = 1'b1;
    end
end

endmodule
