module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

reg heater, aircon, fan;

always @(*)
begin
    if (mode)
    begin
        heater = too_cold;
        aircon = 0;
    end
    else
    begin
        heater = 0;
        aircon = too_hot;
    end

    if (fan_on || heater || aircon)
        fan = 1;
    else
        fan = 0;
end

endmodule
