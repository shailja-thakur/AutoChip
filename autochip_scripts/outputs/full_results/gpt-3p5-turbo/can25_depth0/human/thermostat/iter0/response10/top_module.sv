module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

wire fan_on_req;

assign fan_on_req = fan_on | (mode ? too_cold : too_hot);

assign heater = (mode & too_cold) | fan_on_req;

assign aircon = (~mode & too_hot) | fan_on_req;

assign fan = fan_on | heater | aircon;

endmodule
