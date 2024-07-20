module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output reg heater,
    output reg aircon,
    output reg fan
);
    
    always @(*) begin
        // Control the fan: It will be on if too_cold, too_hot, or fan_on is high
        fan = too_cold | too_hot | fan_on;
        
        if (mode) begin
            // Heating Mode
            heater = too_cold;
            aircon = 0;
        end else begin
            // Cooling Mode
            heater = 0;
            aircon = too_hot;
        end
    end
    
endmodule
