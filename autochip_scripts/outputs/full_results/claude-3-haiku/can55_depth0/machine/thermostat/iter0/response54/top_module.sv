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
    // Determine the state of the fan
    if (too_cold || too_hot || fan_on) begin
        fan = 1'b1;
    end else begin
        fan = 1'b0;
    end

    // Determine the state of the heater
    if (mode && too_cold) begin
        heater = 1'b1;
    end else begin
        heater = 1'b0;
    end

    // Determine the state of the air conditioner
    if (~mode && too_hot) begin
        aircon = 1'b1;
    end else begin
        aircon = 1'b0;
    end
end

endmodule
