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
        // Default values to avoid latches
        heater = 0;
        aircon = 0;
        fan = 0;

        // Determine the state of the fan
        if (fan_on || too_cold || too_hot)
            fan = 1;

        // Determine the state of the heater
        if (mode && too_cold)
            heater = 1;

        // Determine the state of the air conditioner
        if (~mode && too_hot)
            aircon = 1;
    end
endmodule
