module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

// OR gates for inputs a and b
wire ab;
or (ab, a, b);

// OR gates for inputs c and d
wire cd;
or (cd, c, d);

// AND gate for outputs of OR gates
and (q, ab, cd);

endmodule
