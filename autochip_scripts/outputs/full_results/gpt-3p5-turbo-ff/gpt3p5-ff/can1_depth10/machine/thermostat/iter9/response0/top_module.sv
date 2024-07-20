module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output reg heater,
    output reg aircon,
    output reg fan
);

    always@(mode, too_cold, too_hot, fan_on) begin
        if (mode) begin
            heater <= too_cold;
            aircon <= too_hot;
        end else begin
            heater <= 0;
            aircon <= too_hot;
        end
        
        fan <= fan_on || too_cold || too_hot;
    end

endmodule
