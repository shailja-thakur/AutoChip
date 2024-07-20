module top_module(
	input wire ring, 
	input wire vibrate_mode,
	output wire ringer,
	output wire motor
);

assign ringer = ring & !vibrate_mode;
assign motor = ring & vibrate_mode;

endmodule
