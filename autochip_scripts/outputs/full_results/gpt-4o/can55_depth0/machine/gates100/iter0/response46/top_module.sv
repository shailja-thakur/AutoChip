module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);
    // Intermediate variables to hold the results of reductions
    wire and_result, or_result, xor_result;

    // Perform the logical operations
    assign and_result = &in;  // Logical AND of all bits
    assign or_result = |in;   // Logical OR of all bits
    assign xor_result = ^in;  // Logical XOR of all bits

    // Assign the results to the output ports
    assign out_and = and_result;
    assign out_or = or_result;
    assign out_xor = xor_result;
endmodule
