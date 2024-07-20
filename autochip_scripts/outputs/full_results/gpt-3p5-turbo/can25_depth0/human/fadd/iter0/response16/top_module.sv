module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Here we define the internal signals
	wire s1, s2, s3;

	// Instantiate the full adder module
	full_adder FA1(a, b, cin, s1, s2);
	full_adder FA2(s1, s2, s2, s2, s3);
	
	// Assign the outputs to the module outputs
	assign sum = s3;
	assign cout = s2;

endmodule
module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
	
    // Internal signals
    wire w1, w2, w3;
    
    // XOR gates for the half-adder
    xor (w1, a, b);
    xor (sum, w1, cin);
    
    // AND gate for the half-adder
    and (w2, a, b);
    
    // AND gate for the carry-out
    and (w3, w1, cin);
    
    // OR gate for the carry-out
    or (cout, w2, w3);
    
endmodule
