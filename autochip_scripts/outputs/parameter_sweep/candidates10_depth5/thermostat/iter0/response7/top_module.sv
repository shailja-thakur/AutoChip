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

always @(mode or too_cold or too_hot or fan_on)
begin
    if (mode == 1 && too_cold == 1)
    begin
        heater = 1;
        aircon = 0;
    end
    else if (mode == 0 && too_hot == 1)
    begin
        heater = 0;
        aircon = 1;
    end
    else
    begin
        heater = 0;
        aircon = 0;
    end
    
    if (heater == 1 || aircon == 1 || fan_on == 1)
        fan = 1;
    else
        fan = 0;
end

assign heater = heater;
assign aircon = aircon;
assign fan = fan;

endmodule
