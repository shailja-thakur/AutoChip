module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// wire declaration for internal signal
wire [2:0] sum_in;

// assign statement to calculate sum and carry-out
assign sum_in = a + b + cin;
assign cout = (sum_in >= 3'b10) ? 1'b1 : 1'b0;
assign sum = sum_in % 2;

endmodule
