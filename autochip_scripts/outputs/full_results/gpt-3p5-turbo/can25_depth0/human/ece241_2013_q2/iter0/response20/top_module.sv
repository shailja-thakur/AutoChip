module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// Define the internal signals for each input pattern
wire w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15;

// Assign the internal signals to the input patterns
assign w1 = (a==0) && (b==0) && (c==0) && (d==0);
assign w2 = (a==0) && (b==0) && (c==0) && (d==1);
assign w3 = (a==0) && (b==0) && (c==1) && (d==0);
assign w4 = (a==0) && (b==0) && (c==1) && (d==1);
assign w5 = (a==0) && (b==1) && (c==0) && (d==0);
assign w6 = (a==0) && (b==1) && (c==0) && (d==1);
assign w7 = (a==0) && (b==1) && (c==1) && (d==0);
assign w8 = (a==0) && (b==1) && (c==1) && (d==1);
assign w9 = (a==1) && (b==0) && (c==0) && (d==0);
assign w10 = (a==1) && (b==0) && (c==0) && (d==1);
assign w11 = (a==1) && (b==0) && (c==1) && (d==0);
assign w12 = (a==1) && (b==0) && (c==1) && (d==1);
assign w13 = (a==1) && (b==1) && (c==0) && (d==0);
assign w14 = (a==1) && (b==1) && (c==0) && (d==1);
assign w15 = (a==1) && (b==1) && (c==1) && (d==1);

// Output out_sop in minimum sum-of-products form
assign out_sop = w2 || w7 || w15;

// Output out_pos in minimum product-of-sums form
assign out_pos = !w1 && !w2 && !w4 && !w5 && !w6 && !w9 && !w10 && !w13 && !w14;

endmodule
