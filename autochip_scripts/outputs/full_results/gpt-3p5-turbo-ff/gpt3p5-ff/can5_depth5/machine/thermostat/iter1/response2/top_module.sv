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
        begin
            heater = 1;
            aircon = 0;
        end
    else if (!mode && too_hot)
        begin
            heater = 0;
            aircon = 1;
        end
    else
        begin
            heater = 0;
            aircon = 0;
        end

    if (fan_on || too_cold || too_hot)
        fan = 1;
    else
        fan = 0;
end

endmodule
