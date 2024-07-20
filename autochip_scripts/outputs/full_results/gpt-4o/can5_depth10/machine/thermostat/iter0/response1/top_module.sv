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
        // Default values
        heater = 0;
        aircon = 0;
        fan = 0;
        
        // Control heater based on mode and too_cold
        if (mode && too_cold) begin
            heater = 1;
        end

        // Control aircon based on mode and too_hot
        if (!mode && too_hot) begin
            aircon = 1;
        end

        // Control fan based on fan_on or too_cold or too_hot
        if (fan_on || too_cold || too_hot) begin
            fan = 1;
        end
    end

endmodule
