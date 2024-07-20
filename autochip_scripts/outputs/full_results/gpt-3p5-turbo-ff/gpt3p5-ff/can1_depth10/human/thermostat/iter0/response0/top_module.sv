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
reg fan;

always @(*) begin
    if (mode == 1) begin
        heater = too_cold;
        aircon = 0;
        fan = (heater || aircon || fan_on);
    end else begin
        heater = 0;
        aircon = too_hot;
        fan = (heater || aircon || fan_on);
    end
end

endmodule
