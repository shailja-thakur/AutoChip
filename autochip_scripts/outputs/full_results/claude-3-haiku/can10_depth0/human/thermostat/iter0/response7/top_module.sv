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
    // Heating mode
    if (mode == 1'b1) begin
        heater = too_cold;
        aircon = 1'b0;
        fan = (too_cold | heater);
    end
    // Cooling mode
    else begin
        heater = 1'b0;
        aircon = too_hot;
        fan = (too_hot | aircon);
    end

    // Fan-only mode
    if (fan_on == 1'b1) begin
        fan = 1'b1;
    end
end

endmodule
