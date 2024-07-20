module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

reg fan;
reg heater;
reg aircon;

always @(*) begin
    if (too_cold || too_hot || fan_on)
        fan = 1'b1;
    else
        fan = 1'b0;
        
    if (mode && too_cold)
        heater = 1'b1;
    else
        heater = 1'b0;
        
    if (!mode && too_hot)
        aircon = 1'b1;
    else
        aircon = 1'b0;
end

assign fan = fan;
assign heater = heater;
assign aircon = aircon;

endmodule
