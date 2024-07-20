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
    // Initialize outputs to off
    heater = 1'b0;
    aircon = 1'b0;
    fan = 1'b0;

    // Control fan
    if (too_cold || too_hot || fan_on) begin
        fan = 1'b1;
    end

    // Control heater
    if (mode && too_cold) begin
        heater = 1'b1;
    end

    // Control air conditioner
    if (~mode && too_hot) begin
        aircon = 1'b1;
    end
end

endmodule
