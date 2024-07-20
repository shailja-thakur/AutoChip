module top_module (
	input signed [7:0] a,
	input signed [7:0] b,
	output signed [7:0] s,
	output overflow
);

   wire signed [8:0] sum;
   assign sum = a + b;

   assign s = sum[7:0];
   assign overflow = sum[8] ^ sum[7];
  
endmodule
