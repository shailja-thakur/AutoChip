module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    reg fan_reg;
    always @(fan_on or too_cold or too_hot) begin
        fan_reg = fan_on || too_cold || too_hot;
    end
    assign fan = fan_reg;

    reg heater_reg;
    always @(mode or too_cold) begin
        heater_reg = mode && too_cold;
    end
    assign heater = heater_reg;

    reg aircon_reg;
    always @(mode or too_hot) begin
        aircon_reg = !mode && too_hot;
    end
    assign aircon = aircon_reg;
    
endmodule
