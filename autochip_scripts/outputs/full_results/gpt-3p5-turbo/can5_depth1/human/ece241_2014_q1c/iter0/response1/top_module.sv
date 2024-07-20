module top_module (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);

  wire [8:0] sum;
  wire [7:0] carry_in;
  
  assign carry_in = 1'b0;
  assign sum = a + b + carry_in;
  
  assign s = sum[7:0];
  assign overflow = (sum[8] != sum[7]);
  
endmodule
