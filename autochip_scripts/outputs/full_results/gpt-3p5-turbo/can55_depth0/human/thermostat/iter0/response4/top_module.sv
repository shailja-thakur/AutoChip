module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Declare intermediate wire variables
wire fan_control;
wire heater_control;
wire aircon_control;

// Control the fan based on user request and the state of the heater and air conditioner
assign fan = fan_on | (heater_control | aircon_control);

// Control the heater based on the mode and temperature
assign heater = (mode & too_cold & ~too_hot & ~aircon_control) | fan_on;

// Control the air conditioner based on the mode and temperature
assign aircon = (~mode & too_hot & ~too_cold & ~heater_control) | fan_on;

endmodule
