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

always @(mode or too_cold or too_hot or fan_on) begin
    if (mode) begin
        if (too_cold)
            heater = 1;
        else
            heater = 0;
        
        aircon = 0;
        fan = fan_on;
    end
    else begin
        if (too_hot)
            aircon = 1;
        else
            aircon = 0;
        
        heater = 0;
        fan = fan_on;
    end
end

endmodule
