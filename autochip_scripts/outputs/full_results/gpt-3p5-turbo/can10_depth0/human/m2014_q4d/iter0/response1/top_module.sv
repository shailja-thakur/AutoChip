module top_module (
	input clk,
	input in,
	output logic out
);
	
	// Declare intermediate signals
	logic xor_output;
	logic flip_flop_output;

	// Implement XOR gate
	assign xor_output = in ^ out;

	// Implement D flip-flop
	always @(posedge clk) begin
		flip_flop_output <= xor_output;
	end

	// Output declaration
	assign out = flip_flop_output;

endmodule
