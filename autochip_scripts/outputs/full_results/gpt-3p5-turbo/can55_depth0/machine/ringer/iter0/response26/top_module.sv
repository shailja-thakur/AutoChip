module top_module(
	input ring, 
	input vibrate_mode,
	output reg ringer,
	output reg motor
);

	always @(ring or vibrate_mode) begin
		ringer = ring & ~vibrate_mode;
		motor = ring & vibrate_mode;
	end
	
endmodule
