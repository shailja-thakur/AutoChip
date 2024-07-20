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
        if (mode) begin
            if (too_cold)
                heater = 1;
            else
                heater = 0;
            
            aircon = 0; // Air conditioner is off in heating mode
        end
        else begin
            if (too_hot)
                aircon = 1;
            else
                aircon = 0;
            
            heater = 0; // Heater is off in cooling mode
        end
        
        if (fan_on)
            fan = 1;
        else if (heater || aircon)
            fan = 1;
        else
            fan = 0;
    end
    
endmodule
