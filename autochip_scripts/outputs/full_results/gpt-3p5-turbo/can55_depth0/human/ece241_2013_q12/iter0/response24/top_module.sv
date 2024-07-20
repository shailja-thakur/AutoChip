module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);

reg [7:0] Q;
wire abc0, abc1, abc2, abc3, abc4, abc5, abc6, abc7;

assign abc0 = ~A & ~B & ~C;
assign abc1 = ~A & ~B & C;
assign abc2 = ~A & B & ~C;
assign abc3 = ~A & B & C;
assign abc4 = A & ~B & ~C;
assign abc5 = A & ~B & C;
assign abc6 = A & B & ~C;
assign abc7 = A & B & C;

always @(posedge clk) begin
	if (enable) begin
		Q[0] <= S;
		Q[1] <= Q[0];
		Q[2] <= Q[1];
		Q[3] <= Q[2];
		Q[4] <= Q[3];
		Q[5] <= Q[4];
		Q[6] <= Q[5];
		Q[7] <= Q[6];
	end
end

always @* begin
	if (abc0) Z <= Q[0];
	if (abc1) Z <= Q[1];
	if (abc2) Z <= Q[2];
	if (abc3) Z <= Q[3];
	if (abc4) Z <= Q[4];
	if (abc5) Z <= Q[5];
	if (abc6) Z <= Q[6];
	if (abc7) Z <= Q[7];
end

endmodule
