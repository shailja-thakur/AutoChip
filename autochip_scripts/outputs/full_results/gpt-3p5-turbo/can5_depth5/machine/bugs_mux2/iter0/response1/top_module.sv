module top_module (
	input sel,
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] out
);

	always @(*)
	begin
		if (sel == 0) // when sel is 0, set out equal to b
			out <= b;
		else // when sel is 1, set out equal to a
			out <= a;
	end
	
endmodule
