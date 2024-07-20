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
        // Initialize outputs
        heater = 0;
        aircon = 0;
        
        // Determine heater and aircon states based on mode and temperature conditions
        if (mode == 1) begin
            // Heating mode
            if (too_cold) 
                heater = 1;
        end else begin
            // Cooling mode
            if (too_hot) 
                aircon = 1;
        end

        // Determine fan state
        fan = heater | aircon | fan_on;
    end
endmodule
