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
        else
            heater = 0;

        if (!mode && too_hot)
            aircon = 1;
        else
            aircon = 0;

        if (fan_on || too_cold || too_hot)
            fan = 1;
        else
            fan = 0;
    end

endmodule
