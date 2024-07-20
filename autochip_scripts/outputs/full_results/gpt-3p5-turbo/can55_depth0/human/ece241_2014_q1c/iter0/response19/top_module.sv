module top_module (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);
  
  reg [8:0] sum;

  always @(*) begin
    sum = a + b; // adding both numbers
    s = sum[7:0]; // storing the lower 8 bits in s

    // detecting overflow
    if (sum[8] == 1 && sum[7] == 0)
      overflow = 1; // overflow detected
    else if (sum[8] == 0 && sum[7] == 1)
      overflow = 1; // overflow detected
    else
      overflow = 0; // no overflow
  end

endmodule
