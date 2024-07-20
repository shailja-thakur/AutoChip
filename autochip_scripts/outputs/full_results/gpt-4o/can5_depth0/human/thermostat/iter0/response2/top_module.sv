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
        aircon = 0;
        fan = too_cold | fan_on;
    end else begin // Cooling mode
        heater = 0;
        aircon = too_hot;
        fan = too_hot | fan_on;
    end
end

endmodule
