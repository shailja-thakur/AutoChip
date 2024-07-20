module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Internal wire declarations to hold the intermediate values
wire heat_condition;
wire aircon_condition;
wire fan_condition;

// Determine the heater condition: If mode is high and too_cold is high, turn on the heater
assign heat_condition = mode & too_cold;

// Determine the aircon condition: If mode is low and too_hot is high, turn on the aircon
assign aircon_condition = ~mode & too_hot;

// Determine the fan condition: If too_cold, too_hot, or fan_on is high, turn on the fan
assign fan_condition = too_cold | too_hot | fan_on;

// Assign the internal conditions to the output ports
assign heater = heat_condition;
assign aircon = aircon_condition;
assign fan = fan_condition;

endmodule
