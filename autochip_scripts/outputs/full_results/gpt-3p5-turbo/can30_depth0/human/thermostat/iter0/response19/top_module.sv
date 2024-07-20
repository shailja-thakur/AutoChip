module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Instantiate the heater, air conditioner, and fan modules
heater_module heater(.mode(mode), .too_cold(too_cold), .fan_on(fan_on), .heater(heater));
aircon_module aircon(.mode(mode), .too_hot(too_hot), .fan_on(fan_on), .aircon(aircon));
fan_module fan(.fan_on(fan_on), .fan(fan));

endmodule
module heater_module(
    input mode,
    input too_cold,
    input fan_on,
    output heater
);

// Turn on the heater when it is too cold
assign heater = (mode == 1 && too_cold && fan_on);

endmodule
module aircon_module(
    input mode,
    input too_hot,
    input fan_on,
    output aircon
);

// Turn on the air conditioner when it is too hot
assign aircon = (mode == 0 && too_hot && fan_on);

endmodule
module fan_module(
    input fan_on,
    output fan
);

// Turn on the fan when either the heater, air conditioner, or fan are on
assign fan = (fan_on);

endmodule
