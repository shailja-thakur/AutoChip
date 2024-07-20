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
    fan = (too_cold || too_hot || fan_on) ? 1'b1 : 1'b0;

    // Set the heater output
    heater = (mode && too_cold) ? 1'b1 : 1'b0;

    // Set the aircon output
    aircon = (~mode && too_hot) ? 1'b1 : 1'b0;
end

endmodule
