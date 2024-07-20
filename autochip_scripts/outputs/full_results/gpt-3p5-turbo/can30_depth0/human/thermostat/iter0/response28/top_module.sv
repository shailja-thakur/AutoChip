module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Instantiate heater, aircon, and fan modules
heater_module heater_inst(
    .mode(mode),
    .too_cold(too_cold),
    .heater(heater)
);

aircon_module aircon_inst(
    .mode(mode),
    .too_hot(too_hot),
    .aircon(aircon)
);

fan_module fan_inst(
    .fan_on(fan_on),
    .fan(fan)
);

endmodule
module heater_module(
    input mode,
    input too_cold,
    output heater
);

assign heater = (mode == 1) && (too_cold == 1);

endmodule
module aircon_module(
    input mode,
    input too_hot,
    output aircon
);

assign aircon = (mode == 0) && (too_hot == 1);

endmodule
module fan_module(
    input fan_on,
    output fan
);

assign fan = fan_on;

endmodule
