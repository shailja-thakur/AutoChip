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
    // Fan control
    fan = (too_cold || too_hot) || fan_on;

    // Heater control
    if (mode && too_cold) begin
        heater = 1'b1;
    end else begin
        heater = 1'b0;
    end

    // Air conditioner control
    if (~mode && too_hot) begin
        aircon = 1'b1;
    end else begin
        aircon = 1'b0;
    end
end

endmodule
