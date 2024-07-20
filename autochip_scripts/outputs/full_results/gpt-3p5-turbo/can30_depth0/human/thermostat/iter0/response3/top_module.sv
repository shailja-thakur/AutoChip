module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Internal signal to hold the logic for turning on/off the heater, aircon, and fan
wire heater_on;
wire aircon_on;
wire fan_on;

// Logic for controlling the heater
assign heater_on = (mode == 1) && (too_cold || fan_on);
assign heater = heater_on;

// Logic for controlling the air conditioner
assign aircon_on = (mode == 0) && (too_hot || fan_on);
assign aircon = aircon_on;

// Logic for controlling the fan
assign fan = heater_on || aircon_on || fan_on;

endmodule
