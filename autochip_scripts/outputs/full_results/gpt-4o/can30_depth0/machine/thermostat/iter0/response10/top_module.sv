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
    // Default outputs
    heater = 0;
    aircon = 0;
    fan = 0;

    // Determine the fan state
    if (too_cold || too_hot || fan_on) 
        fan = 1;

    // Determine the heater state
    if (mode && too_cold)
        heater = 1;

    // Determine the air conditioning state
    if (~mode && too_hot)
        aircon = 1;
end

endmodule
