module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// Full Adder logic
wire s1, c1, c2;

and #(1) g1 (s1, a, b);
and #(1) g2 (c1, a, cin);
and #(1) g3 (c2, b, cin);

xor #(1) x1 (sum, a, b);
xor #(1) x2 (sum, s1, cin);

or #(1) o1 (cout, c1, c2);

endmodule
