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
    if (mode) begin
        heater = too_cold || fan_on;
        aircon = 0;
    end else begin
        heater = 0;
        aircon = too_hot || fan_on;
    end

    fan = heater || aircon || fan_on;
end

endmodule
