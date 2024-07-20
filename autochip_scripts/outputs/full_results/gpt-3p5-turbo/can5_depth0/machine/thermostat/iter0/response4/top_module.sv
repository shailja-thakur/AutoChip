module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);
    
    reg fan, heater, aircon;
    
    always @(mode, too_cold, too_hot, fan_on)
    begin
        if (fan_on == 1 || too_cold == 1 || too_hot == 1) 
            fan = 1;
        else 
            fan = 0;
        
        if (mode == 1 && too_cold == 1)
            heater = 1;
        else 
            heater = 0;
        
        if (mode == 0 && too_hot == 1)
            aircon = 1;
        else 
            aircon = 0;
    end
    
    assign fan = fan;
    assign heater = heater;
    assign aircon = aircon;

endmodule
