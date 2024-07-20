module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);

	always @(posedge clk) begin
		// Shift enable
		if (shift_ena) begin
			q <= {q[2:0], data};
		end

		// Count enable
		else if (count_ena) begin
			q <= q - 1;
		end
	end

endmodule
