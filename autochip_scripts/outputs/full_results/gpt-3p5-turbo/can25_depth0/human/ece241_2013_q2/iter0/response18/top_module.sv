module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// Define intermediate signals for each input combination
wire [3:0] input_combination;

// Assign binary value to each input combination
assign input_combination = {a, b, c, d};

// Output out_sop with minimum sum-of-products form
assign out_sop = (input_combination == 2'b10) || (input_combination == 2'b111) || (input_combination == 2'b1111);

// Output out_pos with minimum product-of-sums form
assign out_pos = (input_combination != 2'b00) && (input_combination != 2'b01) && (input_combination != 2'b100) && (input_combination != 2'b101) && (input_combination != 2'b110) && (input_combination != 2'b1001) && (input_combination != 2'b1010) && (input_combination != 2'b1101) && (input_combination != 2'b1110);

endmodule
