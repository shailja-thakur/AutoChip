module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// Create internal wire for intermediate signals
wire w1, w2, w3;

// Calculate intermediate signals
xor (w1, a, b);
xor (sum, w1, cin);
and (w2, a, b);
and (w3, w1, cin);

// Calculate output signals
or (cout, w2, w3);

endmodule
