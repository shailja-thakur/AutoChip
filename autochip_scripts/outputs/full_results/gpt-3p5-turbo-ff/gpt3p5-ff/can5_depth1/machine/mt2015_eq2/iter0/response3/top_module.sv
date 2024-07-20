module top_module(
	input [1:0] A,
	input [1:0] B,
	output reg z);  // made output reg to store the value of z

	always @(*)  // combinational logic
	begin
		if (A == B)  // if A is equal to B
			z = 1;  // set z to 1
		else
			z = 0;  // set z to 0
	end
endmodule
