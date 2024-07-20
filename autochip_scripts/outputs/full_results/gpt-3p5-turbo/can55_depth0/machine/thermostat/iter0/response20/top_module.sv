module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output reg heater,
    output reg aircon,
    output reg fan
);

always @(mode, too_hot, too_cold, fan_on) begin
    // Fan control
    if (fan_on || too_cold || too_hot) begin
        fan = 1;
    end else begin
        fan = 0;
    end
    
    // Heater control
    if (mode && too_cold) begin
        heater = 1;
    end else begin
        heater = 0;
    end
    
    // Air conditioner control
    if (!mode && too_hot) begin
        aircon = 1;
    end else begin
        aircon = 0;
    end
end

endmodule
