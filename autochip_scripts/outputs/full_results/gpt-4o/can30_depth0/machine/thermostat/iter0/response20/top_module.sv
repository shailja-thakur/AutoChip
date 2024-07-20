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
    // Initialize all outputs to zero
    heater = 0;
    aircon = 0;
    fan = 0;
    
    // Fan control logic
    if (too_cold || too_hot || fan_on) begin
        fan = 1;
    end
    
    // Heater control logic
    if (mode && too_cold) begin
        heater = 1;
    end
    
    // Air conditioner control logic
    if (~mode && too_hot) begin
        aircon = 1;
    end
end

endmodule
