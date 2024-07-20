module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

    // Intermediate variables for reduction
    wire and_result;
    wire or_result;
    wire xor_result;

    // Perform reduction operations
    assign and_result = &in;  // Reduction AND
    assign or_result = |in;   // Reduction OR
    assign xor_result = ^in;  // Reduction XOR

    // Assign results to outputs
    assign out_and = and_result;
    assign out_or = or_result;
    assign out_xor = xor_result;

endmodule
