module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);

	// Internal signals
	reg [3:0] shift_q;

	always @(posedge clk) begin
		if (shift_ena && !count_ena) begin
			shift_q <= {shift_q[2:0], data};	// Shift data into shift register
		end
		else if (!shift_ena && count_ena) begin
			shift_q <= shift_q - 1;		// Decrement shift register
		end
	end

	assign q = shift_q;

endmodule
