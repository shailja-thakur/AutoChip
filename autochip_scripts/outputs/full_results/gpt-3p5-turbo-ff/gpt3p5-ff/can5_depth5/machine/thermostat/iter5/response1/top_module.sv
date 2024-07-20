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
    heater = (mode && too_cold) ? 1'b1 : 1'b0;
    aircon = (!mode && too_hot) ? 1'b1 : 1'b0;
    fan = (fan_on || too_cold || too_hot) ? 1'b1 : 1'b0;
end

endmodule
