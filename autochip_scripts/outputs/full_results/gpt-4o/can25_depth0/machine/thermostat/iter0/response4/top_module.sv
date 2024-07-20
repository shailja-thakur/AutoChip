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
    // Default assignments
    heater = 0;
    aircon = 0;
    fan = 0;
    
    // Fan control logic
    if (fan_on || too_cold || too_hot)
        fan = 1;
    
    // Heater and aircon control logic
    if (mode) begin
        // Heating mode
        if (too_cold)
            heater = 1;
    end else begin
        // Cooling mode
        if (too_hot)
            aircon = 1;
    end
end

endmodule
