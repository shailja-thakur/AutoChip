module top_module ( input [1:0] A, input [1:0] B, output z ); 
	// Insert your code here
	wire and1 = A[0] & B[0];
	wire and2 = A[1] & B[1];
	wire or1 = and1 | and2;
	assign z = or1;
endmodule