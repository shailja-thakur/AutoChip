module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Internal signals
wire turn_on_heater;
wire turn_on_aircon;
wire turn_on_fan;

// Control logic for turning on and off the heater, air conditioner, and fan
assign turn_on_heater = (mode == 1) && (too_cold == 1);
assign turn_on_aircon = (mode == 0) && (too_hot == 1);
assign turn_on_fan = (fan_on == 1) || (turn_on_heater == 1) || (turn_on_aircon == 1);

// Output assignments
assign heater = (turn_on_heater == 1);
assign aircon = (turn_on_aircon == 1);
assign fan = (turn_on_fan == 1);

endmodule
