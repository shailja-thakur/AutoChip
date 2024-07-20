module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

   wire [3:0] carry; // define a 4-bit wire for the carry

   // instantiate full adder modules for each bit
   full_adder fa0(.a(x[0]), .b(y[0]), .c_in(1'b0), .sum(sum[0]), .carry(carry[0]));
   full_adder fa1(.a(x[1]), .b(y[1]), .c_in(carry[0]), .sum(sum[1]), .carry(carry[1]));
   full_adder fa2(.a(x[2]), .b(y[2]), .c_in(carry[1]), .sum(sum[2]), .carry(carry[2]));
   full_adder fa3(.a(x[3]), .b(y[3]), .c_in(carry[2]), .sum(sum[3]), .carry(carry[3]));
   
   // assign overflow bit as carry out from the most significant bit
   assign sum[4] = carry[3];
endmodule
module full_adder (
   input a,
   input b,
   input c_in,
   output sum,
   output carry
);
   
   // XOR gate for sum
   assign sum = a ^ b ^ c_in;
   
   // generate carry using AND and OR gates
   assign carry = (a & b) | (a & c_in) | (b & c_in);
   
endmodule
