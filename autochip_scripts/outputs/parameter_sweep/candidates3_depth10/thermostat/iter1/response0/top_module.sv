module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater_out,
    output aircon_out,
    output fan_out
);

reg heater;
reg aircon;
reg fan;

assign heater_out = heater;
assign aircon_out = aircon;
assign fan_out = fan;

always @(*)
begin
    if (mode && too_cold)
    begin
        heater = 1;
        aircon = 0;
        fan = 1;
    end
    else if (!mode && too_hot)
    begin
        heater = 0;
        aircon = 1;
        fan = 1;
    end
    else if (fan_on)
    begin
        heater = 0;
        aircon = 0;
        fan = 1;
    end
    else
    begin
        heater = 0;
        aircon = 0;
        fan = 0;
    end
end

endmodule
