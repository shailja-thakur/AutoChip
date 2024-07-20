module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

reg heater;
reg aircon;
wire fan;

always @(mode, too_cold, too_hot, fan_on) begin
    if (mode == 1) begin
        heater = too_cold;
        aircon = 0;
    end else begin
        heater = 0;
        aircon = too_hot;
    end
    
    if (heater || aircon || fan_on) begin
        fan = 1;
    end else begin
        fan = 0;
    end
end

endmodule
