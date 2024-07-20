module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

  reg [7:0] sum;  // internal variable to hold the sum
  reg overflow;  // flag indicating overflow

  always @(a or b) begin
    sum = a + b;  // calculate the sum
    // check for overflow
    if (sum[7] != a[7] && sum[7] != b[7]) overflow = 1;
    else overflow = 0;
  end

  assign s = sum;  // assign the sum to the output
  
endmodule
