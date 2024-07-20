module top_module (
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] s,
  output reg overflow
);

  always @* begin
    wire [8:0] sum;
    sum = a + b;
    s = sum[7:0];
    overflow = (a[7] == b[7] && a[7] != sum[7]);
  end

endmodule
