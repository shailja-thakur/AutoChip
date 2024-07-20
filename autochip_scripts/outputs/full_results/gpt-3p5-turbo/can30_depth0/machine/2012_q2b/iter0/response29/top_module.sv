module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

	// Define intermediate signals
	w_not = ~w;

	and1_in1 = y[0];
	and1_in2 = w;

	or1_in1 = y[1] | y[2] | y[4] | y[5];
	or1_in2 = w_not;

	// Instantiate logic gates
	and1 (
		.input1(and1_in1),
		.input2(and1_in2),
		.output(Y1)
	);

	and3 (
		.input1(or1_in1),
		.input2(or1_in2),
		.output(Y3)
	);

endmodule
module and1 (
	input input1,
	input input2,
	output output
);
	assign output = input1 & input2;
endmodule
module and3 (
	input input1,
	input input2,
	output output
);
	assign output = input1 & input2;
endmodule
