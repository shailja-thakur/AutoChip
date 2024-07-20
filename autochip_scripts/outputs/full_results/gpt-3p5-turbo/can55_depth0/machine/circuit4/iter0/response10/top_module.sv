module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

// Declare internal signals
wire or_result;

// Perform logical OR operation between b and c
assign or_result = b | c;

// Assign the output q to the result of logical OR operation
assign q = or_result;

endmodule
