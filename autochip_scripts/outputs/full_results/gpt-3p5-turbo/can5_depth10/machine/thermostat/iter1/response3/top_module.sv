module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output reg heater,
    output reg aircon,
    output reg fan
);

    always @(mode, too_cold, too_hot, fan_on) begin
        if (fan_on || too_cold || too_hot) begin
            fan = 1'b1;
        end else begin
            fan = 1'b0;
        end
        
        if (mode && too_cold) begin
            heater = 1'b1;
        end else begin
            heater = 1'b0;
        end
        
        if (!mode && too_hot) begin
            aircon = 1'b1;
        end else begin
            aircon = 1'b0;
        end
    end

endmodule
