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
        // Default values
        heater = 0;
        aircon = 0;

        if (mode == 1) begin // Heating mode
            if (too_cold) begin
                heater = 1;
            end
        end else begin // Cooling mode
            if (too_hot) begin
                aircon = 1;
            end
        end

        // Fan control
        fan = heater || aircon || fan_on;
    end

endmodule
