module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

	always @(*)
	begin
		if(vibrate_mode)
		begin
			motor = 1;
			ringer = 0;
		end
		else
		begin
			motor = 0;
			ringer = 1;
		end
	end
endmodule
