module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

// Declare internal signals
reg fan_on_internal;

// Logic to determine the state of the fan
always @(*) begin
	if (fan_on == 1 || (mode == 1 && too_cold == 1) || (mode == 0 && too_hot == 1)) begin
		fan_on_internal = 1;
	end else begin
		fan_on_internal = 0;
	end
end

// Logic to determine the state of the heater
assign heater = (mode == 1 && too_cold == 1 && fan_on_internal == 1) ? 1 : 0;

// Logic to determine the state of the air conditioner
assign aircon = (mode == 0 && too_hot == 1 && fan_on_internal == 1) ? 1 : 0;

// Assign the fan output
assign fan = fan_on_internal;

endmodule
