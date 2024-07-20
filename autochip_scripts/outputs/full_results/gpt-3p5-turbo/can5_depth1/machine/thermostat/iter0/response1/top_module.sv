module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);
    
    reg fan_output;
    reg heater_output;
    reg aircon_output;
    
    // fan control logic
    always @(*)
    begin
        if (too_cold || too_hot || fan_on)
            fan_output = 1;
        else
            fan_output = 0;
    end
    
    // heater control logic
    always @(*)
    begin
        if (mode && too_cold)
            heater_output = 1;
        else
            heater_output = 0;
    end
    
    // aircon control logic
    always @(*)
    begin
        if (!mode && too_hot)
            aircon_output = 1;
        else
            aircon_output = 0;
    end
    
    // assigning outputs
    assign fan = fan_output;
    assign heater = heater_output;
    assign aircon = aircon_output;
    
endmodule
