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
    // Set the fan output
    if (too_cold || too_hot || fan_on)
        fan = 1;
    else
        fan = 0;

    // Set the heater output
    if (mode && too_cold)
        heater = 1;
    else
        heater = 0;

    // Set the aircon output
    if (~mode && too_hot)
        aircon = 1;
    else
        aircon = 0;
end

endmodule
