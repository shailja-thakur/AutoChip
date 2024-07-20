module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Reg to store the state until a change
    reg heater_reg;
    reg aircon_reg;
    reg fan_reg;

    always @(*) begin
        // Heating mode
        if (mode == 1) begin
            if (too_cold == 1) begin
                heater_reg = 1;
                aircon_reg = 0;
                fan_reg = 1;
            end else if (fan_on == 1) begin
                heater_reg = 0;
                aircon_reg = 0;
                fan_reg = 1;
            end else begin
                heater_reg = 0;
                aircon_reg = 0;
                fan_reg = 0;
            end
        end
        // Cooling mode
        else begin
            if (too_hot == 1) begin
                heater_reg = 0;
                aircon_reg = 1;
                fan_reg = 1;
            end else if (fan_on == 1) begin
                heater_reg = 0;
                aircon_reg = 0;
                fan_reg = 1;
            end else begin
                heater_reg = 0;
                aircon_reg = 0;
                fan_reg = 0;
            end
        end
    end

    // Output assignments
    assign heater = heater_reg;
    assign aircon = aircon_reg;
    assign fan = fan_reg;

endmodule
