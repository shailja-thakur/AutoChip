module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output reg heater,
    output reg aircon,
    output reg fan
);

// Always block to update outputs based on inputs
always @(*) begin
    // Determine the fan status
    if (fan_on || too_cold || too_hot) 
        fan = 1;
    else 
        fan = 0;

    // Determine the heater status
    if (mode && too_cold) 
        heater = 1;
    else 
        heater = 0;

    // Determine the air conditioner status
    if (~mode && too_hot) 
        aircon = 1;
    else 
        aircon = 0;
end

endmodule
