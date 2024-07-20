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
    if (mode) begin // Heating mode
        heater = too_cold;
        aircon = 1'b0;
        fan = too_cold || fan_on;
    end else begin // Cooling mode
        heater = 1'b0;
        aircon = too_hot;
        fan = too_hot || fan_on;
    end
end

endmodule
