module top_module (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);
  
  wire [3:0] carry;
  
  // Full Adder 1
  full_adder fa1(
    .a(x[0]),
    .b(y[0]),
    .c_in(1'b0),
    .sum(sum[0]),
    .c_out(carry[0])
  );
  
  // Full Adder 2
  full_adder fa2(
    .a(x[1]),
    .b(y[1]),
    .c_in(carry[0]),
    .sum(sum[1]),
    .c_out(carry[1])
  );
  
  // Full Adder 3
  full_adder fa3(
    .a(x[2]),
    .b(y[2]),
    .c_in(carry[1]),
    .sum(sum[2]),
    .c_out(carry[2])
  );
  
  // Full Adder 4
  full_adder fa4(
    .a(x[3]),
    .b(y[3]),
    .c_in(carry[2]),
    .sum(sum[3]),
    .c_out(carry[3])
  );
  
  // Overflow bit
  assign sum[4] = carry[3];
  
endmodule
