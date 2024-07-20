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
        // Control the heater output
        if (mode && too_cold) begin
            heater = 1;
        end else begin
            heater = 0;
        end

        // Control the aircon output
        if (!mode && too_hot) begin
            aircon = 1;
        end else begin
            aircon = 0;
        end
        
        // Control the fan output
        if (too_cold || too_hot || fan_on) begin
            fan = 1;
        end else begin
            fan = 0;
        end
    end

endmodule
