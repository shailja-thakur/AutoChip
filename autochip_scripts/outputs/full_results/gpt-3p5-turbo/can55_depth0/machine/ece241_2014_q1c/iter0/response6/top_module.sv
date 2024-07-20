module top_module (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);

  wire [7:0] sum;
  reg overflow;
  
  assign sum = a + b;
  assign s = sum[7:0];
  
  always @(*) begin
    if ((a[7] == b[7]) && (sum[7] != a[7]))
      overflow = 1;
    else
      overflow = 0;
  end
  
endmodule
