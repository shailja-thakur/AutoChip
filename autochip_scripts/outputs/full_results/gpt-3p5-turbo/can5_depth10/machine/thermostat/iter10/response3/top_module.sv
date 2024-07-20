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
        heater = 0;
        aircon = 0;
        fan = 0;

        if (mode && too_cold)
            heater = 1;
        else if (!mode && too_hot)
            aircon = 1;

        if (fan_on || too_cold || too_hot)
            fan = 1;
    end

endmodule
