module top_module (
	input [99:0] a,
	input [99:0] b,
	input sel,
	output reg [99:0] out
);

	always @(sel)
	begin
		if (sel == 1'b0)
			out <= a;
		else if (sel == 1'b1)
			out <= b;
	end

endmodule
