module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Instantiate internal signals
wire heater_on; // Signal to turn on the heater
wire aircon_on; // Signal to turn on the air conditioner
wire fan_on_internal; // Signal to turn on the fan

// Logic for turning on the heater
assign heater_on = (mode && too_cold) || fan_on;

// Logic for turning on the air conditioner
assign aircon_on = (!mode && too_hot) || fan_on;

// Logic for turning on the fan
assign fan_on_internal = fan_on || heater_on || aircon_on;

// Assign outputs
assign heater = heater_on;
assign aircon = aircon_on;
assign fan = fan_on_internal;

endmodule
