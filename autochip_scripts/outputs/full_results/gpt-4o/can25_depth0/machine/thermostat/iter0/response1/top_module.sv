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
        // Control fan output
        if (fan_on || too_cold || too_hot) begin
            fan = 1;
        end else begin
            fan = 0;
        end

        // Control heater output
        if (mode && too_cold) begin
            heater = 1;
        end else begin
            heater = 0;
        end

        // Control air conditioner output
        if (!mode && too_hot) begin
            aircon = 1;
        end else begin
            aircon = 0;
        end
    end

endmodule
