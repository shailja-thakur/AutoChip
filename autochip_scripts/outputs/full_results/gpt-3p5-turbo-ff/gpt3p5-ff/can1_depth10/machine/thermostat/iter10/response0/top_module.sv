module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output reg heater,
    output reg aircon,
    output reg fan
);

    always @(mode or too_cold or too_hot or fan_on) begin
        if (mode) begin
            heater = too_cold;
            aircon = 0;
            fan = fan_on || too_cold || too_hot;
        end else begin
            heater = 0;
            aircon = too_hot;
            fan = fan_on || too_hot;
        end
    end

endmodule
