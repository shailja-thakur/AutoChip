module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Temporary signals to store intermediate values
wire temp_heater;
wire temp_aircon;

// Logic to control heater
assign heater = (mode & too_cold) | (fan_on & ~too_hot);
assign temp_heater = mode & too_cold;

// Logic to control air conditioner
assign aircon = (~mode & too_hot) | (fan_on & ~too_cold);
assign temp_aircon = ~mode & too_hot;

// Logic to control fan
assign fan = fan_on | temp_heater | temp_aircon;

endmodule
