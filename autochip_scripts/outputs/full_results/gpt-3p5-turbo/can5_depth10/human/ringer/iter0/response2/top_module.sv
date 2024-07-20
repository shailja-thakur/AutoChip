module top_module(
	input wire ring,
	input wire vibrate_mode,
	output wire ringer,
	output wire motor
);

	always @(ring, vibrate_mode) begin
		if (vibrate_mode == 1'b1) begin
			ringer <= 1'b0;
			motor <= 1'b1;
		end else begin
			ringer <= 1'b1;
			motor <= 1'b0;
		end
	end

endmodule
