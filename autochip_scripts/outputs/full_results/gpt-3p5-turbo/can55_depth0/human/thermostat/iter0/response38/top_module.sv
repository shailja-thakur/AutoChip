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

always @(mode or too_cold or too_hot or fan_on) begin
    if (mode == 1) begin // heating mode
        if (too_cold == 1) begin
            heater = 1;
            fan = 1;
        end
        else begin
            heater = 0;
            if (fan_on == 1) begin
                fan = 1;
            end
            else begin
                fan = 0;
            end
        end
        aircon = 0;
    end
    else begin // cooling mode
        if (too_hot == 1) begin
            aircon = 1;
            fan = 1;
        end
        else begin
            aircon = 0;
            if (fan_on == 1) begin
                fan = 1;
            end
            else begin
                fan = 0;
            end
        end
        heater = 0;
    end
end

endmodule
