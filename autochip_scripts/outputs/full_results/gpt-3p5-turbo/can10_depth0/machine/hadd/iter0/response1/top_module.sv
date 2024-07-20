module top_module (
    input a,
    input b,
    output sum,
    output cout
);
	
	// Declare internal wire for carry out
	wire cout_temp;
	
	// Assign statement to calculate sum and carry out
	assign {cout_temp, sum} = a + b;
	assign cout = cout_temp;
	
endmodule
