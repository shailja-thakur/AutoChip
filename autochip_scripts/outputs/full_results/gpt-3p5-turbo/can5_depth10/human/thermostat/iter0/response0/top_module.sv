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
    if (mode == 1 && too_cold)
        heater = 1;
    else
        heater = 0;
    
    if (mode == 0 && too_hot)
        aircon = 1;
    else
        aircon = 0;
    
    if (heater || aircon || fan_on)
        fan = 1;
    else
        fan = 0;
end

assign heater = heater;
assign aircon = aircon;
assign fan = fan;

endmodule
