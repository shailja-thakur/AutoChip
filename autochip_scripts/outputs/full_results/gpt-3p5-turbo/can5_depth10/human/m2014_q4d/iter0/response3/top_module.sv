module top_module (
	input clk,
	input in,
	output logic out
);

	// Declare flip-flop inputs
	logic xor_in_1;
	logic xor_in_2;

	// Declare flip-flop output
	logic d_ff_out;

	// Declare flip-flop
	always_ff @(posedge clk) begin
		d_ff_out <= xor_in_1 ^ xor_in_2;
	end

	// Connect XOR inputs to flip-flop outputs
	assign xor_in_1 = in;
	assign xor_in_2 = d_ff_out;

	// Assign flip-flop output to module output
	assign out = d_ff_out;

endmodule
