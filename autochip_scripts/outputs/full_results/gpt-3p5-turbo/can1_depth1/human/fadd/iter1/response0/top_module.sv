module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
  // Instantiate the full adder module
  full_adder FA1(.a(a), .b(b), .cin(cin), .cout(cout), .sum(sum));
  
endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
  wire w1, w2, w3;
  xor (w1, a, b);
  xor (sum, w1, cin);
  and (w2, a, b);
  and (w3, w1, cin);
  or (cout, w2, w3);
endmodule
