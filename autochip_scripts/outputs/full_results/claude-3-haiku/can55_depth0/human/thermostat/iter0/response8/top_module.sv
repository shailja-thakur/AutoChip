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
    if (mode) begin
        heater = too_cold;
        aircon = 0;
        fan = heater;
    // Cooling mode    
    end else begin
        heater = 0;
        aircon = too_hot;
        fan = aircon;
    end
    
    // User-requested fan
    if (fan_on) begin
        fan = 1;
    end
end

endmodule
