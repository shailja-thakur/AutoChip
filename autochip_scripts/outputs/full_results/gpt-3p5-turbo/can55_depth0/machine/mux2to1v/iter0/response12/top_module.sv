module top_module (
	input [99:0] a,
	input [99:0] b,
	input sel,
	output [99:0] out
);
	always @(sel) begin
		if (sel == 0) begin
			out <= a;
		end else begin
			out <= b;
		end
	end
endmodule
