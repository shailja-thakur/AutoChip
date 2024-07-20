module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output reg heater,
    output reg aircon,
    output reg fan
);

// Always block to compute heater, aircon, and fan outputs
always @(*) begin
    if (mode) begin // Heating mode
        heater = too_cold;
        aircon = 0;
    end else begin // Cooling mode
        heater = 0;
        aircon = too_hot;
    end
    fan = fan_on | heater | aircon;
end

endmodule
