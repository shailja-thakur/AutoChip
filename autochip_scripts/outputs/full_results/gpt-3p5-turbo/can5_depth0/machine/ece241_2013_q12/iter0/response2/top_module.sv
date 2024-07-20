module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);

reg [7:0] q;

always @(posedge clk) begin
	if (enable) begin
		q <= S;
		Z <= (A & B & C) ? q[7] :
		      (A & B & ~C) ? q[6] :
		      (A & ~B & C) ? q[5] :
		      (A & ~B & ~C) ? q[4] :
		      (~A & B & C) ? q[3] :
		      (~A & B & ~C) ? q[2] :
		      (~A & ~B & C) ? q[1] :
		      (~A & ~B & ~C) ? q[0] :
		      1'bx;
	end
end

endmodule
