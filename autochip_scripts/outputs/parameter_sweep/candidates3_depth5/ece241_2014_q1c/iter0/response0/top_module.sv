module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

   wire [7:0] a_neg;
   wire [7:0] b_neg;
   wire [7:0] s_neg;
   wire overflow_neg;

   assign a_neg = (~a) + 1;
   assign b_neg = (~b) + 1;
   assign s_neg = a_neg + b_neg;
   assign s = ~s_neg + 1;

   assign overflow_neg = ((a[7] & ~b[7] & ~s[7]) | (~a[7] & b[7] & s[7]));
   assign overflow = ~overflow_neg;
  
endmodule
