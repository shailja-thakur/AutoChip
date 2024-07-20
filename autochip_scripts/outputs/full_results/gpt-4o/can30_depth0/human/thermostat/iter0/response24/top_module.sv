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
        if (mode) begin // Heating mode
            heater_reg = too_cold;
            aircon_reg = 1'b0;
        end else begin // Cooling mode
            heater_reg = 1'b0;
            aircon_reg = too_hot;
        end

        // Fan should be on if heater or aircon is on, or if fan_on is requested
        fan_reg = heater_reg || aircon_reg || fan_on;
    end

    assign heater = heater_reg;
    assign aircon = aircon_reg;
    assign fan = fan_reg;
endmodule
