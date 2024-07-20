module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

reg heater;
reg aircon;
reg fan;

always @(*) begin
    if (mode == 1) begin // Heating mode
        if (too_cold == 1) begin
            heater = 1;
            fan = 1;
        end else if (fan_on == 1) begin
            heater = 0;
            fan = 1;
        end else begin
            heater = 0;
            fan = 0;
        end
        aircon = 0;
    end else begin // Cooling mode
        if (too_hot == 1) begin
            aircon = 1;
            fan = 1;
        end else if (fan_on == 1) begin
            aircon = 0;
            fan = 1;
        end else begin
            aircon = 0;
            fan = 0;
        end
        heater = 0;
    end
end

endmodule
