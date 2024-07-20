module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

  reg [8:0] sum;
  
  always @(a or b) begin
    sum = a + b;
    if ((a[7] == 1 && b[7] == 1 && sum[8] == 0) || (a[7] == 0 && b[7] == 0 && sum[8] == 1))
      overflow = 1;
    else
      overflow = 0;
  end
  
  assign s = sum[7:0];

endmodule
