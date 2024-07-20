module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

  wire signed [8:0] sum;

  assign sum = a + b;
  assign s = sum[7:0];
  
  // Check for overflow: if the sign bits of a and b are the same, but the sign of the resulting sum is different, overflow occurs
  assign overflow = (~a[7] & ~b[7] & sum[8]) | (a[7] & b[7] & ~sum[8]);

endmodule
