module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);
	always @(*) begin
		if (vibrate_mode == 1'b1)
			motor = 1'b1;
		else
			ringer = 1'b1;
	end
endmodule
