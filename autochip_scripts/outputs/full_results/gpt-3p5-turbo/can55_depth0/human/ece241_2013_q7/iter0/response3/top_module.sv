module top_module (
	input clk,
	input j,
	input k,
	output reg Q
);
	always @(posedge clk) begin
		if (j && k) begin
			Q <= ~Q;
		end else if (j) begin
			Q <= 1;
		end else if (k) begin
			Q <= 0;
		end
	end
endmodule
