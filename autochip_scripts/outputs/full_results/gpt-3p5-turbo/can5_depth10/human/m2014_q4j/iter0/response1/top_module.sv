module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

  wire [3:0] carry;
  wire [3:0] sum_intermediate;
  
  // Instantiate full adders
  full_adder FA0 (
    .a(x[0]),
    .b(y[0]),
    .cin(0),
    .sum(sum_intermediate[0]),
    .cout(carry[0])
  );
  
  full_adder FA1 (
    .a(x[1]),
    .b(y[1]),
    .cin(carry[0]),
    .sum(sum_intermediate[1]),
    .cout(carry[1])
  );
  
  full_adder FA2 (
    .a(x[2]),
    .b(y[2]),
    .cin(carry[1]),
    .sum(sum_intermediate[2]),
    .cout(carry[2])
  );
  
  full_adder FA3 (
    .a(x[3]),
    .b(y[3]),
    .cin(carry[2]),
    .sum(sum_intermediate[3]),
    .cout(carry[3])
  );
  
  // Connect the output bits to the sum output
  assign sum = {carry[3], sum_intermediate};
  
  // Include the full adder module definition here
  
  // Implement the full adder module 
  
  module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
  );
  
    wire w1, w2, w3;
    assign w1 = a ^ b;
    assign sum = w1 ^ cin;
    assign w2 = a & b;
    assign w3 = w1 & cin;
    assign cout = w2 | w3;
  
  endmodule
