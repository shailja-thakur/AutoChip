module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);

	always @(posedge clk) begin
		if (shift_ena)
			q <= {q[2:0], data}; // Shift in data from MSB
		else if (count_ena)
			q <= q - 1; // Decrement the value in the shift register
	end

endmodule
