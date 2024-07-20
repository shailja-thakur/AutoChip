module top_module (
	input clk,
	input in,
	output logic out
);

	// Compute the XOR of 'in' and 'out'
	logic xor_result;
	assign xor_result = in ^ out;
	
	// D flip-flop to store the output
	always_ff @(posedge clk) begin
		out <= xor_result;
	end

endmodule
