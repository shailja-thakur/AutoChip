module top_module(
	input mode,
	input too_cold,
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

// Variables to hold the state of each device
reg heater_state;
reg aircon_state;
reg fan_state;

// Assign the outputs based on the input conditions
always @(*) begin
    if (mode == 1) begin // Heating mode
        heater_state = too_cold || fan_on;
        aircon_state = 0;
        fan_state = heater_state || fan_on;
    end else begin // Cooling mode
        heater_state = 0;
        aircon_state = too_hot || fan_on;
        fan_state = aircon_state || fan_on;
    end
end

assign heater = heater_state;
assign aircon = aircon_state;
assign fan = fan_state;

endmodule
