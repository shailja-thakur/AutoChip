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

assign fan = fan_on | (heater | aircon);

always @(mode, too_cold, too_hot, fan_on)
begin
    if (mode == 1) // Heating mode
    begin
        heater = (too_cold == 1);
        aircon = 0;
    end
    else // Cooling mode
    begin
        heater = 0;
        aircon = (too_hot == 1);
    end
end

assign fan = fan_on || (heater || aircon);

endmodule
