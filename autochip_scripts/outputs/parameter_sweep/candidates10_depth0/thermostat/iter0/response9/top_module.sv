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

always @(mode, too_cold, too_hot, fan_on) begin
    if (mode == 1) begin // Heating mode
        if (too_cold == 1) begin // Too cold, turn on heater and fan
            heater = 1;
            aircon = 0;
            fan = 1;
        end else begin // Not too cold, turn off heater and fan
            heater = 0;
            aircon = 0;
            if (fan_on == 1) begin // Fan requested to turn on
                fan = 1;
            end else begin // Fan not requested, turn off fan
                fan = 0;
            end
        end
    end else begin // Cooling mode
        if (too_hot == 1) begin // Too hot, turn on air conditioner and fan
            heater = 0;
            aircon = 1;
            fan = 1;
        end else begin // Not too hot, turn off air conditioner and fan
            heater = 0;
            aircon = 0;
            if (fan_on == 1) begin // Fan requested to turn on
                fan = 1;
            end else begin // Fan not requested, turn off fan
                fan = 0;
            end
        end
    end
end

endmodule
