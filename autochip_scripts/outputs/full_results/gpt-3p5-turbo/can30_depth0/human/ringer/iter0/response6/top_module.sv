module top_module(
	input wire ring, 
	input wire vibrate_mode,
	output wire ringer,
	output wire motor
);
    assign ringer = (vibrate_mode) ? 0 : ring;
    assign motor = (vibrate_mode) ? ring : 0;
endmodule
