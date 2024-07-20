module top_module (
	input in1,
	input in2,
	output logic out
);
// Define internal signals
logic not_in2;
logic and_result;

/* Implement the logical NOT of in2 */
assign not_in2 = ~in2;

/* Implement the logical AND of in1 and not_in2 */
assign and_result = in1 & not_in2;

/* Assign the output signal */
assign out = and_result;

endmodule
