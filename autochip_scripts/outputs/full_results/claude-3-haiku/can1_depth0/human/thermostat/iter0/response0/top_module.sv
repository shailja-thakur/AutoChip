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
    if (mode) begin
        heater = too_cold;
        aircon = 0;
        fan = heater || fan_on;
    // Cooling mode
    end else begin
        heater = 0;
        aircon = too_hot;
        fan = aircon || fan_on;
    end
end

endmodule
