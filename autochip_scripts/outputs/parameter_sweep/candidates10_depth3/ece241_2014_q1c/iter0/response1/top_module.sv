module top_module (
	input signed [7:0] a,
	input signed [7:0] b,
	output signed [7:0] s,
	output overflow
);
  reg [8:0] sum;
  
  always @(*) begin
    sum = a + b; // Perform addition
    s = sum[7:0]; // Assign sum[7:0] to s
    
    if (sum[8] == 1)
      overflow = 1; // Set overflow to 1 if sum[8] is 1
    else
      overflow = 0; // Set overflow to 0 if sum[8] is 0
  end
  
endmodule
