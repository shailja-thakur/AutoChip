module top_module (
	input sel,
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] out
);

	// Logic for determining the value of 'out' based on the value of 'sel'
	always @(sel, a, b)
	begin
		if (sel == 0)
			out <= b;
		else if (sel == 1)
			out <= a;
	end

endmodule
