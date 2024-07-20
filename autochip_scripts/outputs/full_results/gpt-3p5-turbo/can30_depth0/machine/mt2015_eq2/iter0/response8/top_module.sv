module top_module(
	input [1:0] A,
	input [1:0] B,
	output reg z); // Add 'reg' keyword to declare 'z' as a reg-type output

	always @(*) // Use combinational logic for the output assignment
	begin
		if (A == B) // Use '==' for comparison
			z = 1;
		else
			z = 0;
	end

endmodule
