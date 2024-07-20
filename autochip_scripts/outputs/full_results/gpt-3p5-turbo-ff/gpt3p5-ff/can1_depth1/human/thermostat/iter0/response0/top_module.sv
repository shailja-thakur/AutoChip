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
    output reg heater
);

always @(mode or too_cold) begin
    if (mode && too_cold) begin
        heater <= 1;
    end else begin
        heater <= 0;
    end
end

endmodule
module aircon_module(
    input mode,
    input too_hot,
    output reg aircon
);

always @(mode or too_hot) begin
    if (!mode && too_hot) begin
        aircon <= 1;
    end else begin
        aircon <= 0;
    end
end

endmodule
module fan_module(
    input fan_on,
    output reg fan
);

always @(fan_on) begin
    if (fan_on) begin
        fan <= 1;
    end else begin
        fan <= 0;
    end
end

endmodule
