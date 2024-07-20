module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);
    reg heater_reg;
    reg aircon_reg;
    reg fan_reg;

    always @(*) begin
        if (mode) begin  // heating mode
            heater_reg = too_cold;
            aircon_reg = 0;
        end else begin  // cooling mode
            heater_reg = 0;
            aircon_reg = too_hot;
        end

        fan_reg = fan_on | heater_reg | aircon_reg;
    end

    assign heater = heater_reg;
    assign aircon = aircon_reg;
    assign fan = fan_reg;
endmodule
