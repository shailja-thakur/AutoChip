module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);
	always @(posedge clk or posedge R) begin
		if (R)
			Q <= 1'b0;
		else if (E)
			Q <= L ? R : w;
	end
endmodule
