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
    // Fan control logic
    fan = fan_on || too_cold || too_hot;
    
    // Heater control logic
    if (mode == 1'b1 && too_cold == 1'b1) begin
        heater = 1'b1;
    end else begin
        heater = 1'b0;
    end
    
    // Air conditioner control logic
    if (mode == 1'b0 && too_hot == 1'b1) begin
        aircon = 1'b1;
    end else begin
        aircon = 1'b0;
    end
end

endmodule
