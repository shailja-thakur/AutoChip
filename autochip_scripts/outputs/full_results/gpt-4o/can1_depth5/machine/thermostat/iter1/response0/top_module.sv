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
    // Default values
    heater = 0;
    aircon = 0;
    fan = 0;

    // Fan control
    if (fan_on || (too_cold || too_hot)) begin
        fan = 1;
    end

    // Heater control in heating mode
    if (mode && too_cold) begin
        heater = 1;
    end

    // Air conditioner control in cooling mode
    if (!mode && too_hot) begin
        aircon = 1;
    end
end

endmodule
