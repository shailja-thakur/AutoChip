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
        fan = fan_on || too_cold || too_hot;
    end

    // Heater control
    always @(*)
    begin
        heater = mode && too_cold;
    end

    // Aircon control
    always @(*)
    begin
        aircon = mode && too_hot;
    end

endmodule
