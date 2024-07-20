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
assign Z = (A==0 && B==0 && C==0) ? Q[0] :
          (A==0 && B==0 && C==1) ? Q[1] :
          (A==0 && B==1 && C==0) ? Q[2] :
          (A==0 && B==1 && C==1) ? Q[3] :
          (A==1 && B==0 && C==0) ? Q[4] :
          (A==1 && B==0 && C==1) ? Q[5] :
          (A==1 && B==1 && C==0) ? Q[6] :
                                  Q[7];

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

endmodule
