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
    fan = fan_on;

    if(mode == 1) begin
        // Heating mode
        if(too_cold) begin
            heater = 1;
            fan = 1;
        end
    end else begin
        // Cooling mode
        if(too_hot) begin
            aircon = 1;
            fan = 1;
        end
    end
end

endmodule
