module top_module (
    input a,
    input b,
    output sum,
    output cout
);
	// Define internal wires
	wire w1, w2;

	// Create XOR gate for sum
	xor gate1(w1, a, b);

	// Create AND gate for carry-out
	and gate2(w2, a, b);

	// Output wires
	assign sum = w1;
	assign cout = w2;
	
endmodule
module xor (
	output out,
	input in1,
	input in2
);

	assign out = in1 ^ in2;
	
endmodule
module and (
	output out,
	input in1,
	input in2
);

	assign out = in1 & in2;
	
endmodule
