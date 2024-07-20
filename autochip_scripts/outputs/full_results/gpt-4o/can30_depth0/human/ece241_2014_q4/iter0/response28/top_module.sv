module top_module (
	input clk,
	input x,
	output reg z
);

	reg q1, q2, q3; // Flip-flop outputs
	
	wire xor_out, and_out, or_out; // Gate outputs
	wire q1_bar, q2_bar, q3_bar; // Complemented flip-flop outputs

	// Complement the outputs of flip-flops for AND and OR gates
	assign q1_bar = ~q1;
	assign q2_bar = ~q2;
	assign q3_bar = ~q3;
	
	// XOR gate
	assign xor_out = x ^ q1;
	
	// AND gate
	assign and_out = x & q2_bar;
	
	// OR gate
	assign or_out = x | q3_bar;
		
	// Sequential logic for flip-flops
	always @(posedge clk) begin
		q1 <= xor_out;
		q2 <= and_out;
		q3 <= or_out;
	end
	
	// XNOR gate for final output
	assign z = ~(q1 ^ q2 ^ q3);

endmodule
