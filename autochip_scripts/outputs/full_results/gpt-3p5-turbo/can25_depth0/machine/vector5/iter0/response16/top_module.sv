module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);

	// The module computes the bitwise exclusive-or of the 25-bit vector ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} } 
	// and the 25-bit vector {5{a,b,c,d,e}}.
	
	// First vector: ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} }
	wire [24:0] first_vector;
	assign first_vector = {~(5{a}), ~(5{b}), ~(5{c}), ~(5{d}), ~(5{e})};
	
	// Second vector: {5{a,b,c,d,e}}
	wire [24:0] second_vector;
	assign second_vector = {5{a,b,c,d,e}};
	
	// Compute the bitwise exclusive-or of the two vectors
	assign out = first_vector ^ second_vector;
	
endmodule
