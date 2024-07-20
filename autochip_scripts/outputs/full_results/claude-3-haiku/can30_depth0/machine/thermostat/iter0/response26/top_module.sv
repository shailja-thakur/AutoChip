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
    // Initialize outputs to 0
    heater = 1'b0;
    aircon = 1'b0;
    fan = 1'b0;

    // Determine fan state
    if (too_cold || too_hot || fan_on) begin
        fan = 1'b1;
    end

    // Determine heater state
    if (mode && too_cold) begin
        heater = 1'b1;
    end

    // Determine air conditioner state
    if (!mode && too_hot) begin
        aircon = 1'b1;
    end
end

endmodule
