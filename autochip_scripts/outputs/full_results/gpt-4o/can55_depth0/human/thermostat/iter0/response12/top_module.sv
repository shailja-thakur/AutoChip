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
        fan = 0;
        
        // Heat mode
        if (mode == 1) begin
            if (too_cold == 1) begin
                heater = 1;
                fan = 1;
            end
        end
        // Cool mode
        else begin
            if (too_hot == 1) begin
                aircon = 1;
                fan = 1;
            end
        end
        
        // Independent Fan control
        if (fan_on == 1) begin
            fan = 1;
        end
    end

endmodule
