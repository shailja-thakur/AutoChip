module top_module (
	input a,
	input b,
	output sum,
	output cout
);
	
	// Declare internal signals
	wire sum_int, cout_int;
	
	// Instantiate the ha_module
	ha_module ha1 (.a(a), .b(b), .sum(sum_int), .carryout(cout_int));
	
	// Assign outputs
	assign sum = sum_int;
	assign cout = cout_int;
	
endmodule
module ha_module (
	input a,
	input b,
	output sum,
	output carryout
);
	
	assign sum = a ^ b;
	assign carryout = a && b;
	
endmodule
