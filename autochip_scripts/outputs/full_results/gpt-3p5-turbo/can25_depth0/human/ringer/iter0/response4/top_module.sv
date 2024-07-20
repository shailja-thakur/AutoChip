module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

wire ringer, motor;

assign ringer = ~vibrate_mode & ring;
assign motor = vibrate_mode & ring;

endmodule
