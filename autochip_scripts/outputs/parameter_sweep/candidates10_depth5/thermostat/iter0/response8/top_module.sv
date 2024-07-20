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

always @(*)
begin
    if (mode == 1) begin // heating mode
        if (too_cold || fan_on)
            heater = 1;
        else
            heater = 0;
        
        aircon = 0; // air conditioner off in heating mode
        
        if (heater || fan_on)
            fan = 1;
        else
            fan = 0;
    end
    else begin // cooling mode
        if (too_hot || fan_on)
            aircon = 1;
        else
            aircon = 0;
        
        heater = 0; // heater off in cooling mode
        
        if (aircon || fan_on)
            fan = 1;
        else
            fan = 0;
    end
end

endmodule
