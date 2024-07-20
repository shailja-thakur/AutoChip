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
reg fan_override;

always @(*)
begin
    if (mode == 1) // Heating Mode
    begin
        heater = too_cold;
        aircon = 0;
    end
    else // Cooling Mode
    begin
        heater = 0;
        aircon = too_hot;
    end
    
    fan_override = (fan_on || heater || aircon);
    
    if (fan_override)
        fan = 1;
    else
        fan = 0;
end

assign heater = heater;
assign aircon = aircon;
assign fan = fan;

endmodule
