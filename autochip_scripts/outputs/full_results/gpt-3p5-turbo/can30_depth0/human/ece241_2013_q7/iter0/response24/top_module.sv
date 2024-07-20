module top_module (
	input clk,
	input j,
	input k,
	output reg Q
);
	always @(posedge clk) begin
		if (j==1 && k==1)
			Q <= ~Q;
		else if (j==1 && k==0) // If J=1 and K=0, set Q to 1
			Q <= 1'b1;
		else if (j==0 && k==1) // If J=0 and K=1, set Q to 0
			Q <= 1'b0;
	end
endmodule
