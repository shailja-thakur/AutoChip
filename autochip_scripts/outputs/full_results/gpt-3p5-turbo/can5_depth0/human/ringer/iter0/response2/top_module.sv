module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

reg ringer;
reg motor;

// assign an initial value
always @(posedge ring or posedge vibrate_mode)
	begin
		if (vibrate_mode == 1)
			motor <= 1;
		else
			ringer <= 1;
	end
	
// assign a default value
always @(negedge ring or negedge vibrate_mode)
	begin
		if (vibrate_mode == 1)
			motor <= 0;
		else
			ringer <= 0;
	end

endmodule
