module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

wire ~vibrate_mode;
wire ~ring_and_vibrate_mode;

assign ~vibrate_mode = ~vibrate_mode;
assign ~ring_and_vibrate_mode = ~(ring & vibrate_mode);

assign ringer = ~ring_and_vibrate_mode;
assign motor = ~vibrate_mode;
endmodule
