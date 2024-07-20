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
        if (mode && too_cold)
            heater = 1;
        else
            heater = 0;

        if (!mode && too_hot)
            aircon = 1;
        else
            aircon = 0;
    end

    assign fan = fan_on || too_cold || too_hot; // Continuous assignment for 'fan' output

endmodule
