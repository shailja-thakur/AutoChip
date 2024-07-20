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
        // Default outputs
        heater = 0;
        aircon = 0;
        
        if (mode) begin // Heating mode
            if (too_cold) begin
                heater = 1;
            end
        end
        else begin // Cooling mode
            if (too_hot) begin
                aircon = 1;
            end
        end
        
        fan = fan_on || heater || aircon; // Fan is on if either the fan_on signal is high, or heater or aircon is on
    end

endmodule
