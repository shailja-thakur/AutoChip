module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Internal signals for heater and air conditioner
    reg heater_reg;
    reg aircon_reg;
    
    // Heater control logic
    always @(*) begin
        if (mode == 1 && too_cold == 1) begin
            heater_reg = 1;
        end else begin
            heater_reg = 0;
        end
    end

    // Air conditioner control logic
    always @(*) begin
        if (mode == 0 && too_hot == 1) begin
            aircon_reg = 1;
        end else begin
            aircon_reg = 0;
        end
    end

    // Fan control logic
    always @(*) begin
        if (heater_reg == 1 || aircon_reg == 1 || fan_on == 1) begin
            fan = 1;
        end else begin
            fan = 0;
        end
    end

    // Assign outputs
    assign heater = heater_reg;
    assign aircon = aircon_reg;

endmodule
