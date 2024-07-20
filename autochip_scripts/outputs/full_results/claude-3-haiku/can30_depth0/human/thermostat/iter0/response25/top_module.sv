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
    // Heating mode
    if (mode == 1'b1) begin
        if (too_cold == 1'b1) begin
            heater = 1'b1;
            aircon = 1'b0;
            fan = 1'b1;
        end
        else begin
            heater = 1'b0;
            aircon = 1'b0;
            fan = fan_on;
        end
    end
    // Cooling mode
    else begin
        if (too_hot == 1'b1) begin
            heater = 1'b0;
            aircon = 1'b1;
            fan = 1'b1;
        end
        else begin
            heater = 1'b0;
            aircon = 1'b0;
            fan = fan_on;
        end
    end
end

endmodule
