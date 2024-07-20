module top_module (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);

  wire [1:0] sum_temp;
  assign sum_temp = (a + b + cin) % 2;
  
  assign cout = (a + b + cin) >= 2 ? 1'b1 : 1'b0;
  assign sum = sum_temp[0];

endmodule
