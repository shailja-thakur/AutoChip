module top_module (
	input clk,
	input in,
	output reg out
);

	always @(posedge clk) begin
		out <= out ^ in; // Toggle the output using XOR with input
	end

endmodule
