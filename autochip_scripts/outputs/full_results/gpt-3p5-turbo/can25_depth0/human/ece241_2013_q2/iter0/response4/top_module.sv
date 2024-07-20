module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// Define the output wire
	wire out;
	
	// Define the intermediate wires for the input conditions
	wire cond_0, cond_1, cond_2, cond_7, cond_15;
	wire cond_4, cond_5, cond_6, cond_9, cond_10, cond_13, cond_14;
	
	// Define the intermediate wire for the numbers that never occur
	wire cond_3, cond_8, cond_11, cond_12;
	
	// Connect the input conditions
	assign cond_0 = (a == 0) && (b == 0) && (c == 0) && (d == 0);
	assign cond_1 = (a == 0) && (b == 0) && (c == 0) && (d == 1);
	assign cond_2 = (a == 0) && (b == 0) && (c == 1) && (d == 0);
	assign cond_7 = (a == 0) && (b == 1) && (c == 1) && (d == 1);
	assign cond_15 = (a == 1) && (b == 1) && (c == 1) && (d == 1);
	
	assign cond_4 = (a == 0) && (b == 1) && (c == 0) && (d == 0);
	assign cond_5 = (a == 0) && (b == 1) && (c == 0) && (d == 1);
	assign cond_6 = (a == 0) && (b == 1) && (c == 1) && (d == 0);
	assign cond_9 = (a == 1) && (b == 0) && (c == 0) && (d == 1);
	assign cond_10 = (a == 1) && (b == 0) && (c == 1) && (d == 0);
	assign cond_13 = (a == 1) && (b == 1) && (c == 0) && (d == 1);
	assign cond_14 = (a == 1) && (b == 1) && (c == 0) && (d == 0);
	
	assign cond_3 = 0;
	assign cond_8 = 0;
	assign cond_11 = 0;
	assign cond_12 = 0;
	
	// Calculate the output in minimum sum-of-products form
	assign out_sop = cond_2 | cond_7 | cond_15;
	
	// Calculate the output in minimum product-of-sums form
	assign out_pos = ~(cond_0 & cond_1 & cond_4 & cond_5 & cond_6 & cond_9 & cond_10 & cond_13 & cond_14);

endmodule
