module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

  wire [3:0] carry;
  
  // Instantiate 4 full adder modules to perform the addition
  full_adder fa0(
    .x(x[0]),
    .y(y[0]),
    .cin(0),
    .sum(sum[0]),
    .cout(carry[0])
  );
  
  full_adder fa1(
    .x(x[1]),
    .y(y[1]),
    .cin(carry[0]),
    .sum(sum[1]),
    .cout(carry[1])
  );
  
  full_adder fa2(
    .x(x[2]),
    .y(y[2]),
    .cin(carry[1]),
    .sum(sum[2]),
    .cout(carry[2])
  );
  
  full_adder fa3(
    .x(x[3]),
    .y(y[3]),
    .cin(carry[2]),
    .sum(sum[3]),
    .cout(carry[3])
  );
  
  // Assign the overflow bit to the most significant carry bit
  assign sum[4] = carry[3];
  
endmodule
module full_adder (
  input x,
  input y,
  input cin,
  output sum,
  output cout
);
  // Implement the full adder logic using XOR, AND, and OR gates
  wire s;
  wire c1;
  wire c2;
  
  assign s = x ^ y ^ cin;
  assign cout = (x & y) | (cin & (x ^ y));
  assign sum = s;
  
endmodule
