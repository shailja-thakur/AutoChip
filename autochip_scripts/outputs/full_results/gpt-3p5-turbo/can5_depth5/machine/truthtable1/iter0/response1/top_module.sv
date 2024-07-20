module top_module (
	input x3,
	input x2,
	input x1,
	output f
);

// Intermediate signals
wire not_x3, not_x2, not_x1;

// Calculate the negation of input signals
assign not_x3 = ~x3;
assign not_x2 = ~x2;
assign not_x1 = ~x1;

// Calculate intermediate combinations
wire comb1 = (~x3 & x2 & ~x1);
wire comb2 = (~x3 & x2 & x1);
wire comb3 = (x3 & ~x2 & x1);
wire comb4 = (x3 & x2 & x1);

// Calculate the output signal f using logical OR operation
assign f = comb1 | comb2 | comb3 | comb4;

endmodule
