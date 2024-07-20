module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output reg fan
);

    // Determine the state of the fan
    always @(*) begin
        fan = fan_on || too_cold || too_hot;
    end

    // Determine the state of the heater
    assign heater = mode && too_cold;

    // Determine the state of the air conditioner
    assign aircon = ~mode && too_hot;

endmodule
