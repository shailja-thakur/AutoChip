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
        // Default assignments
        heater = 0;
        aircon = 0;
        
        // Heating mode
        if (mode == 1) begin
            if (too_cold == 1) begin
                heater = 1;
            end
        end
        // Cooling mode
        else begin
            if (too_hot == 1) begin
                aircon = 1;
            end
        end
        
        // Fan control
        if (heater == 1 || aircon == 1 || fan_on == 1) begin
            fan = 1;
        end else begin
            fan = 0;
        end
    end

endmodule
