module top_module(
	input [1:0] A,
	input [1:0] B,
	output reg z);  // Added 'reg' keyword to declare z as a registered output
	always @* begin  // Added always block for a combinational logic
		if (A == B)  // Use '==' operator for equality comparison
			z = 1;  // Assign z to 1 if A equals B
		else
			z = 0;  // Assign z to 0 if A is not equal to B
	end  // End of always block
endmodule
