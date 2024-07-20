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
        heater = 0;
        aircon = 0;
        fan = 0;

        if (mode && too_cold)
            heater = 1;

        if (!mode && too_hot)
            aircon = 1;

        fan = fan_on || too_cold || too_hot;
    end

endmodule
