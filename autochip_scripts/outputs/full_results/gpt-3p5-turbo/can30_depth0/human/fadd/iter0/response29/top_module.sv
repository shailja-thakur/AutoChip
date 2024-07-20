module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// Create internal wires for the circuit
wire ab;
wire ab_cin;
wire acin_sum;

// Instantiate the required gates
and u1(ab, a, b);
xor u2(acin_sum, a, b);
xor u3(sum, acin_sum, cin);
and u4(ab_cin, a, b, cin);
or u5(cout, ab, ab_cin);

endmodule
