module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Declare internal signal
reg fan_on_internal;

// Logic for fan_on signal
always @ (fan_on)
    fan_on_internal <= fan_on;

// Logic for heater and aircon based on mode and temperature
always @ (mode or too_cold or too_hot)
begin
    if (mode == 1) // heating mode
    begin
        if (too_cold == 1) // too cold, turn on heater and fan
        begin
            heater <= 1;
            aircon <= 0;
            fan <= 1;
        end
        else // not too cold, turn off heater and fan
        begin
            heater <= 0;
            aircon <= 0;
            if (fan_on_internal == 1)
                fan <= 1;
            else
                fan <= 0;
        end
    end
    else // cooling mode
    begin
        if (too_hot == 1) // too hot, turn on aircon and fan
        begin
            heater <= 0;
            aircon <= 1;
            fan <= 1;
        end
        else // not too hot, turn off aircon and fan
        begin
            heater <= 0;
            aircon <= 0;
            if (fan_on_internal == 1)
                fan <= 1;
            else
                fan <= 0;
        end
    end
end

endmodule
