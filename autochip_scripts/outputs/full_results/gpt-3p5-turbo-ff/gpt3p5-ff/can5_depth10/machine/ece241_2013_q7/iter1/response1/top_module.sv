module top_module (
	input clk,
	input j,
	input k,
	output reg Q
);
	
	reg Q_next;

	always @(posedge clk) begin
		if(j & ~Q)
			Q_next <= j;
		else if(~k & Q)
			Q_next <= 0;
		else if(j & k)
			Q_next <= ~Q;
		end

	always @(posedge clk) begin
		Q <= Q_next;
	end

endmodule
