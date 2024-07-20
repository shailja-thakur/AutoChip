module top_module (
	input clk,
	input in,
	output logic out
);
	// Declare the flip flop
	reg flip_flop;

	// Declare the XOR gate
	wire xor_gate;

	// Connect inputs to XOR gate
	xor_gate xor_gate_inst(.in1(in), .in2(flip_flop), .out(xor_gate));

	// Positive edge triggered D flip-flop
	always @(posedge clk)
	begin
		flip_flop <= xor_gate;
	end

	// Output of the flip-flop
	assign out = flip_flop;

endmodule
