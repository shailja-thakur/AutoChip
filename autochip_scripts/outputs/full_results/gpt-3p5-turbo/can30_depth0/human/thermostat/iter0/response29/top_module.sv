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
    if(mode) begin
        heater = too_cold;
        aircon = 0;
        fan = (fan_on || (heater || aircon));
    end else begin
        aircon = too_hot;
        heater = 0;
        fan = (fan_on || (heater || aircon));
    end
end

endmodule
