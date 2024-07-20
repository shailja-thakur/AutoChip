module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Outputs are initially set to 0
assign heater = 0;
assign aircon = 0;
assign fan = 0;

// Turn on heater, aircon, and fan based on mode and temperature conditions
always @ (mode or too_cold or too_hot or fan_on)
begin
    if (mode == 1 && too_cold == 1) // Heating mode, too cold
    begin
        heater = 1;
        fan = 1;
    end
    else if (mode == 0 && too_hot == 1) // Cooling mode, too hot
    begin
        aircon = 1;
        fan = 1;
    end
    else if (fan_on == 1) // Fan requested to be turned on
    begin
        fan = 1;
    end
    else // All conditions are false, turn off all devices
    begin
        heater = 0;
        aircon = 0;
        fan = 0;
    end
end

endmodule
