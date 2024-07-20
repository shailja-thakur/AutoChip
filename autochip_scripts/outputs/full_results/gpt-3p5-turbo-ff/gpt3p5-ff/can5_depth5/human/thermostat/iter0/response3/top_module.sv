module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Declare internal signals
reg heater_on;
reg aircon_on;

// Logic for heater
always @ (mode, too_cold, fan_on)
begin
    if (mode == 1 && too_cold == 1)
        heater_on = 1;
    else if (fan_on == 1)
        heater_on = 1;
    else
        heater_on = 0;
end

// Logic for air conditioner
always @ (mode, too_hot, fan_on)
begin
    if (mode == 0 && too_hot == 1)
        aircon_on = 1;
    else if (fan_on == 1)
        aircon_on = 1;
    else
        aircon_on = 0;
end

// Logic for fan
always @ (mode, too_cold, too_hot, fan_on)
begin
    if (heater_on == 1 || aircon_on == 1 || fan_on == 1)
        fan = 1;
    else
        fan = 0;
end

// Assign outputs
assign heater = heater_on;
assign aircon = aircon_on;

endmodule
