module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);

	// Compute the inverted vector of {5{a,b,c,d,e}}
	reg [24:0] inverted_vector;
	assign inverted_vector = {5{~(a|b|c|d|e)}};

	// Compute the bitwise exclusive-or of the two vectors
	assign out = inverted_vector ^ {5{a,b,c,d,e}};
  
endmodule
