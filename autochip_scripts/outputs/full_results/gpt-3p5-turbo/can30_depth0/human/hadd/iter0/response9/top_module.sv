module top_module (
    input a,
    input b,
    output sum,
    output cout
);
	// Instantiate the half adder module
	half_adder u1 (.a(a), .b(b), .sum(sum), .cout(cout));

endmodule
module half_adder (
    input a,
    input b,
    output sum,
    output cout
);
	// Implement the half adder logic
	assign sum = a ^ b;
	assign cout = a & b;

endmodule
