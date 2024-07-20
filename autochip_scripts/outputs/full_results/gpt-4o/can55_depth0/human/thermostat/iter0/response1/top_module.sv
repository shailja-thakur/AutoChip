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
        // Initialize all outputs to 0
        heater = 0;
        aircon = 0;
        fan = 0;

        // Determine heater and aircon status based on mode
        if (mode == 1) begin // heating mode
            if (too_cold) begin
                heater = 1;
            end
        end else begin // cooling mode
            if (too_hot) begin
                aircon = 1;
            end
        end

        // Determine fan status
        if (heater || aircon || fan_on) begin
            fan = 1;
        end
    end

endmodule
