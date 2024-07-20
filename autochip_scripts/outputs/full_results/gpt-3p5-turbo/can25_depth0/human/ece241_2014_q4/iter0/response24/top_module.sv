module top_module (
	input clk,
	input x,
	output z
);
	// Declare the D flip-flops
	reg d_ff1, d_ff2, d_ff3;
	
	// Declare the flip-flop outputs
	reg q1, q2, q3;
	
	// Define the logic gates
	wire xor_out, and_out, or_out;
	
	// Assign the inputs of the logic gates
	assign xor_out = x ^ q1;
	assign and_out = x & ~q2;
	assign or_out = x | ~q3;
	
	// Update the flip-flops on rising edge of the clock
	always @(posedge clk) begin
		d_ff1 <= xor_out;
		d_ff2 <= and_out;
		d_ff3 <= or_out;
	end
	
	// Assign the flip-flop outputs to the XOR gate inputs
	assign q1 = d_ff1;
	assign q2 = d_ff2;
	assign q3 = d_ff3;
	
	// Assign the output of the three flip-flops to the XNOR gate
	assign z = ~(q1 ^ q2 ^ q3);
	
endmodule
