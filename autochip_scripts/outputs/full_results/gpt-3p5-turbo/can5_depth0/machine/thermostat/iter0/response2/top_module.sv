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
    
    always @(mode or fan_on or too_cold or too_hot)
        begin
            fan = fan_on || too_cold || too_hot;
            
            if (mode)
                heater = too_cold;
            else
                heater = 0;
            
            if (!mode)
                aircon = too_hot;
            else
                aircon = 0;
        end
    
    assign fan = fan;
    assign heater = heater;
    assign aircon = aircon;
    
endmodule
