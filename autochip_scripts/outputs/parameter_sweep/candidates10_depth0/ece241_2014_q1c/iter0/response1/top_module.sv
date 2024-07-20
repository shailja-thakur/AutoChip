module top_module (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);
  
  reg [7:0] sum;
  
  always @(*) begin
    sum = a + b;
    if (a[7] && b[7] && !sum[7])
      overflow = 1;
    else if (!a[7] && !b[7] && sum[7])
      overflow = 1;
    else
      overflow = 0;
  end
  
  assign s = sum;
  
endmodule
