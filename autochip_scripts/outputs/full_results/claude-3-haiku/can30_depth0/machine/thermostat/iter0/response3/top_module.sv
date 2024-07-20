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
    // Set the default state of the outputs
    heater = 0;
    aircon = 0;
    fan = 0;
    
    // Control the fan
    if (too_cold || too_hot || fan_on) begin
        fan = 1;
    end
    
    // Control the heater
    if (mode && too_cold) begin
        heater = 1;
    end
    
    // Control the air conditioner
    if (~mode && too_hot) begin
        aircon = 1;
    end
end

endmodule
