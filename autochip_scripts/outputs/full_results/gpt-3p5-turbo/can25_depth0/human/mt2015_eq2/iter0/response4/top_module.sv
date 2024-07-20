module top_module(
	input [1:0] A,
	input [1:0] B,
	output reg z); // Declare z as a registered output

	always @* begin
		if (A == B)
			z = 1; // Assign 1 to z if A = B
		else
			z = 0; // Assign 0 to z otherwise
	end
	
endmodule
