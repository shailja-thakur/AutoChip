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
        // Determine the state of the fan
        fan = fan_on || too_cold || too_hot;

        // Determine the state of the heater
        heater = mode && too_cold;

        // Determine the state of the air conditioner
        aircon = ~mode && too_hot;
    end

endmodule
