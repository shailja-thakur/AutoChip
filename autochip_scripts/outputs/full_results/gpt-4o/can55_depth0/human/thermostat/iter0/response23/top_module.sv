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
        // Initialize outputs to 0
        heater = 0;
        aircon = 0;
        fan = 0;
        
        if (mode == 1'b1) begin // Heating mode
            if (too_cold == 1'b1) begin
                heater = 1;
                fan = 1;
            end
        end else if (mode == 1'b0) begin // Cooling mode
            if (too_hot == 1'b1) begin
                aircon = 1;
                fan = 1;
            end
        end
        
        if (fan_on == 1'b1) begin
            fan = 1;
        end
    end

endmodule
