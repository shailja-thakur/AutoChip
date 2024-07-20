module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// Create the full adder circuit
wire s0, s1, c0, c1, c2;

and #(2) u1(s0, a, b);
or #(2) u2(s1, a, b);

xor #(2) u3(sum, s0, cin);
xor #(2) u4(cout, s1, c0);

and #(2) u5(c0, cin, s0);
and #(2) u6(c1, cin, s1);

or #(2) u7(c2, c0, c1);

// Assign the outputs
assign s = sum;
assign cout = c2;

endmodule
