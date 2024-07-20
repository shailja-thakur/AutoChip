module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);

	// Compute the first vector ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} }
	// and store the result in a temporary signal
	wire [24:0] temp;
	assign temp = {~(5'b0), ~{a}, ~(5'b0), ~{b}, ~(5'b0), ~{c}, ~(5'b0), ~{d}, ~(5'b0), ~{e}};

	// Compute the second vector {5{a,b,c,d,e}}
	// and store the result in the output signal
	assign out = {5'b0, {a}, 5'b0, {b}, 5'b0, {c}, 5'b0, {d}, 5'b0, {e}};

	// Compute the bitwise exclusive-or of the two vectors
	// and assign the result to the output signal
	assign out = temp ^ out;

endmodule
