module top_module (
	input clk,
	input in,
	output logic out
);
	// Declare flip-flop signals
	logic d_ff_input;
	logic d_ff_output;
	
	// Declare xor gate output
	logic xor_output;

	// Positive edge-triggered D flip-flop
	always_ff @(posedge clk) begin
		d_ff_input <= xor_output;
	    d_ff_output <= d_ff_input;
	end

	// XOR gate
	assign xor_output = in ^ d_ff_output;
	
	// Assign output
	assign out = d_ff_output;
	
endmodule
