module top_module (
	input clk,
	input in,
	output logic out
);

	// XOR gate takes 'in' and 'out' as inputs and produces 'xor_out' as output
	wire xor_out;
	assign xor_out = in ^ out;

	// D flip-flop that takes 'xor_out' as input and is triggered on positive edge of 'clk'
	always_ff @(posedge clk) begin
		out <= xor_out;
	end

endmodule
