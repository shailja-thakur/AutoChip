module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);
    // Temperature thresholds
    parameter COLD_THRESHOLD = 20;
    parameter HOT_THRESHOLD = 30;
    
    reg heater_on;  // Heater control signal
    reg aircon_on;  // Air conditioner control signal
    
    // Logic to control the heater and air conditioner based on mode and temperature conditions
    always @(*) begin
        if (mode) begin  // Heating mode
            if (too_cold)
                heater_on = 1;
            else
                heater_on = 0;
            
            aircon_on = 0;
        end else begin  // Cooling mode
            if (too_hot)
                aircon_on = 1;
            else
                aircon_on = 0;
            
            heater_on = 0;
        end
    end
    
    // Logic to control the fan
    always @(*) begin
        if (fan_on || heater_on || aircon_on)
            fan = 1;
        else
            fan = 0;
    end
    
    // Assign outputs
    assign heater = heater_on;
    assign aircon = aircon_on;
    
endmodule
