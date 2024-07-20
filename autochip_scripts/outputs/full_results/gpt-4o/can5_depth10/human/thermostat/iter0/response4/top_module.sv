module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    reg heater_reg, aircon_reg, fan_reg;

    always @(*) begin
        // Initialize outputs
        heater_reg = 0;
        aircon_reg = 0;
        fan_reg = fan_on;

        if (mode) begin // Heating mode
            if (too_cold) begin
                heater_reg = 1;
                fan_reg = 1;
            end
        end else begin // Cooling mode
            if (too_hot) begin
                aircon_reg = 1;
                fan_reg = 1;
            end
        end
    end

    // Assign the registered values to the outputs
    assign heater = heater_reg;
    assign aircon = aircon_reg;
    assign fan = fan_reg;

endmodule
