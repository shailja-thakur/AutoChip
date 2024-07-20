module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);

	initial q = 4'b0000;

	always @(posedge clk) begin
		if (shift_ena) begin
			q <= {q[2:0], data};  // Shift data into q
		end else if (count_ena) begin
			q <= q - 1;  // Decrement q
		end
		// No action if both enable signals are low
	end
endmodule
