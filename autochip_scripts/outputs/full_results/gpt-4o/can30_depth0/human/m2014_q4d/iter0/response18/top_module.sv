module top_module (
	input clk,
	input in,
	output logic out
);

	// Intermediate signal for XOR output
	logic xor_out;

	// XOR gate
	assign xor_out = in ^ out;

	// D flip-flop
	always_ff @(posedge clk) begin
		out <= xor_out;
	end
	
endmodule
