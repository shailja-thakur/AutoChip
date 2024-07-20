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
    // Determine the fan output
    fan = (too_cold | too_hot) | fan_on;

    // Determine the heater output
    heater = (mode & too_cold);

    // Determine the air conditioner output
    aircon = (~mode & too_hot);
end

endmodule
