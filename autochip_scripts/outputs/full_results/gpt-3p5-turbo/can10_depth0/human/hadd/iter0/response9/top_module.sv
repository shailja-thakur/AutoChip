module top_module(
	input a,
	input b,
	output sum,
	output cout
);
	
	// Declare internal signals
	wire s, c;
	
	// Instantiate the half adder
	half_adder HA1(.a(a), .b(b), .sum(s), .cout(c));
	
	// Assigning outputs
	assign sum = s;
	assign cout = c;
	
endmodule
module half_adder (
	input a,
	input b,
	output sum,
	output cout
);
	
	// Logic for sum and carry-out
	assign sum = a ^ b;
	assign cout = a & b;
	
endmodule
