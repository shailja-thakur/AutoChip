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

always @(posedge clk) begin
	if (enable) begin
		Q <= {S, Q[7:1]};
	end
	if (A == 0 && B == 0 && C == 0) begin
		Z <= Q[0];
	end else if (A == 0 && B == 0 && C == 1) begin
		Z <= Q[1];
	end else if (A == 0 && B == 1 && C == 0) begin
		Z <= Q[2];
	end else if (A == 0 && B == 1 && C == 1) begin
		Z <= Q[3];
	end else if (A == 1 && B == 0 && C == 0) begin
		Z <= Q[4];
	end else if (A == 1 && B == 0 && C == 1) begin
		Z <= Q[5];
	end else if (A == 1 && B == 1 && C == 0) begin
		Z <= Q[6];
	end else if (A == 1 && B == 1 && C == 1) begin
		Z <= Q[7];
	end
end

endmodule
