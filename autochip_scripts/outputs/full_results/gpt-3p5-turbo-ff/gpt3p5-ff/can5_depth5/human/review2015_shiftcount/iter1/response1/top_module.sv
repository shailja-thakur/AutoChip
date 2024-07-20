module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);

	// Internal signals
	reg [3:0] shift_q;
	reg [3:0] shift_q_reg;

	always @(posedge clk) begin
		shift_q_reg <= shift_q;
		if (shift_ena) begin
			shift_q <= {data, shift_q[3:1]};	// Shift data into shift register
		end
		if (count_ena) begin
			shift_q <= shift_q_reg - 1;		// Decrement shift register
		end
	end

	assign q = shift_q;

endmodule
