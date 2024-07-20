module top_module (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);
  
  wire [3:0] carry;
  
  // Define the full adders
  full_adder fa0(.a(x[0]), .b(y[0]), .cin(0), .sum(sum[0]), .cout(carry[0]));
  full_adder fa1(.a(x[1]), .b(y[1]), .cin(carry[0]), .sum(sum[1]), .cout(carry[1]));
  full_adder fa2(.a(x[2]), .b(y[2]), .cin(carry[1]), .sum(sum[2]), .cout(carry[2]));
  full_adder fa3(.a(x[3]), .b(y[3]), .cin(carry[2]), .sum(sum[3]), .cout(carry[3]));
  
  // Connect the overflow bit
  assign sum[4] = carry[3];
  
endmodule
module full_adder (
  input a,
  input b,
  input cin,
  output sum,
  output cout
);
  
  wire s, c1, c2;
  
  // Implement XOR gates
  xor_gate xor0(.a(a), .b(b), .z(s));
  xor_gate xor1(.a(s), .b(cin), .z(sum));
  
  // Implement AND gates
  and_gate and0(.a(a), .b(b), .z(c1));
  and_gate and1(.a(s), .b(cin), .z(c2));
  and_gate and2(.a(a), .b(cin), .z(carry));
  
  // Implement OR gate
  or_gate or0(.a(c1), .b(c2), .z(cout));
  
endmodule
module xor_gate (
  input a,
  input b,
  output z
);
  assign z = a ^ b;
endmodule
module and_gate (
  input a,
  input b,
  output z
);
  assign z = a & b;
endmodule
module or_gate (
  input a,
  input b,
  output z
);
  assign z = a | b;
endmodule
