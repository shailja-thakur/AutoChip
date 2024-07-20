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
    if (mode == 1'b1) begin  // Heating mode
        if (too_cold) begin
            heater = 1'b1;
            aircon = 1'b0;
            fan = 1'b1;
        end else begin
            heater = 1'b0;
            aircon = 1'b0;
            fan = fan_on;
        end
    end else begin  // Cooling mode
        if (too_hot) begin
            heater = 1'b0;
            aircon = 1'b1;
            fan = 1'b1;
        end else begin
            heater = 1'b0;
            aircon = 1'b0;
            fan = fan_on;
        end
    end
end

endmodule
