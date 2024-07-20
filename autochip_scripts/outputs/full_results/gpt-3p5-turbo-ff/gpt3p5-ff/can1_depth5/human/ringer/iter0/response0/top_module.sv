module top_module(
	input ring,
	input vibrate_mode,
	output ringer,
	output motor
);

// Assign ringer and motor outputs based on the input conditions
always @ (ring, vibrate_mode)
begin
	if (vibrate_mode)
		begin
			ringer <= 0;
			motor <= 1;
		end
	else
		begin
			ringer <= 1;
			motor <= 0;
		end
end

endmodule
