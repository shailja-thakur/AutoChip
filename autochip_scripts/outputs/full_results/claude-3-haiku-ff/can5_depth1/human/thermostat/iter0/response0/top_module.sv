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
    if (mode == 1) begin // Heating mode
        heater = too_cold;
        aircon = 0;
        fan = heater | fan_on;
    end
    else begin // Cooling mode
        heater = 0;
        aircon = too_hot;
        fan = aircon | fan_on;
    end
end

endmodule
