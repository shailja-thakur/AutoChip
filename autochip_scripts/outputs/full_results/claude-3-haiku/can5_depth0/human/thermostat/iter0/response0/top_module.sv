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
    // Default state
    heater = 0;
    aircon = 0;
    fan = 0;

    if (mode) begin // Heating mode
        if (too_cold) begin
            heater = 1;
            fan = 1;
        end
    end else begin // Cooling mode
        if (too_hot) begin
            aircon = 1;
            fan = 1;
        end
    end

    // Always turn on the fan if requested by the user
    if (fan_on) begin
        fan = 1;
    end
end

endmodule
