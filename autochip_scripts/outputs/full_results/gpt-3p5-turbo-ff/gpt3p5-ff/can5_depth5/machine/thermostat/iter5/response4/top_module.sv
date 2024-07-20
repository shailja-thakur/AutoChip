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
    heater = (mode && too_cold);
    aircon = (!mode && too_hot);
    fan = fan_on || too_cold || too_hot;
end

endmodule
