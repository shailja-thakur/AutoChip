module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output reg heater,
    output reg aircon,
    output reg fan
);

    always@(mode, too_cold, too_hot, fan_on) begin
        fan = (too_cold || too_hot || fan_on) ? 1'b1 : 1'b0;
        
        if(mode) begin
            heater <= (too_cold) ? 1'b1 : 1'b0;
            aircon <= 1'b0;
        end else begin
            heater <= 1'b0;
            aircon <= (too_hot) ? 1'b1 : 1'b0;
        end
    end

endmodule
