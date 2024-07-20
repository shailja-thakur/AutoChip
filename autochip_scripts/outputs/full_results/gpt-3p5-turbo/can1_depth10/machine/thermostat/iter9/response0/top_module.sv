module top_module(
    input wire mode,
    input wire too_cold,
    input wire too_hot,
    input wire fan_on,
    output reg heater,
    output reg aircon,
    output reg fan
);

    // Fan control
    always @(*)
    begin
        if (fan_on || too_cold || too_hot)
            fan = 1'b1;
        else
            fan = 1'b0;
    end

    // Heater control
    always @(*)
    begin
        if (mode && too_cold)
            heater = 1'b1;
        else
            heater = 1'b0;
    end

    // Aircon control
    always @(*)
    begin
        if (~mode && too_hot)
            aircon = 1'b1;
        else
            aircon = 1'b0;
    end

endmodule
