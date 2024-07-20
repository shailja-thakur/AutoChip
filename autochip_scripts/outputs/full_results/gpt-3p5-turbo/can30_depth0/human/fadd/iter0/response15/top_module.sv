module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);
	// Define internal wires
	wire w1, w2;

	// Instantiate three half adders
	half_adder ha1 (.a(a), .b(b), .sum(w1), .cout(w2));
	half_adder ha2 (.a(w1), .b(cin), .sum(sum), .cout(w1));
	half_adder ha3 (.a(w2), .b(w1), .sum(cout), .cout(cout));
endmodule
module half_adder (
    input a,
    input b,
    output sum,
    output cout
);
	// XOR gate for sum calculation
	xor(sum, a, b);

	// AND gate for carry calculation
	and(cout, a, b);
endmodule
