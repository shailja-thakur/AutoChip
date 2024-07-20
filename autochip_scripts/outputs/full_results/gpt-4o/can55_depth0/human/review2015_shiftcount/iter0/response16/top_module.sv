module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);

	always @(posedge clk) begin
		if (shift_ena) begin
			q <= {q[2:0], data};  // Shift in new data (MSB first)
		end
		else if (count_ena) begin
			q <= q - 1;  // Decrement the value in the register
		end
		// No action if both or neither control signals are asserted
	end

endmodule
