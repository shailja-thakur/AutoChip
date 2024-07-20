module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

wire ab_or;
wire cd_or;

assign ab_or = a | b;  // Bitwise OR of inputs a and b
assign cd_or = c | d;  // Bitwise OR of inputs c and d
assign q = ab_or & cd_or;  // Bitwise AND of the two OR results

endmodule
