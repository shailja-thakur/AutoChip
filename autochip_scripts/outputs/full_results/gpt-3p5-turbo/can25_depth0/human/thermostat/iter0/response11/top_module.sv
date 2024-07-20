module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

reg heater, aircon, fan;

always @(mode or too_cold or too_hot or fan_on) begin
    // Heating mode
    if (mode) begin
        if (too_cold) begin
            heater = 1;
            fan = 1;
        end
        else begin
            heater = 0;
            fan = fan_on;
        end
        aircon = 0;
    end
    // Cooling mode
    else begin
        if (too_hot) begin
            aircon = 1;
            fan = 1;
        end
        else begin
            aircon = 0;
            fan = fan_on;
        end
        heater = 0;
    end
end

endmodule
