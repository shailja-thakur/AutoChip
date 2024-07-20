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
        // Default states
        heater = 0;
        aircon = 0;
        fan = 0;

        // Determine fan state
        if (fan_on || too_cold || too_hot) begin
            fan = 1;
        end

        // Determine heater state
        if (mode && too_cold) begin
            heater = 1;
        end

        // Determine aircon state
        if (!mode && too_hot) begin
            aircon = 1;
        end
    end
endmodule
