module top_module(
    input mode, // 1 for heating, 0 for cooling
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    reg heater_reg, aircon_reg, fan_reg;

    always @(*) begin
        if (mode == 1) begin // Heating mode
            heater_reg = too_cold;
            aircon_reg = 0;
        end
        else begin // Cooling mode
            heater_reg = 0;
            aircon_reg = too_hot;
        end

        if (heater_reg || aircon_reg || fan_on) begin
            fan_reg = 1;
        end
        else begin
            fan_reg = 0;
        end
    end

    assign heater = heater_reg;
    assign aircon = aircon_reg;
    assign fan = fan_reg;

endmodule
