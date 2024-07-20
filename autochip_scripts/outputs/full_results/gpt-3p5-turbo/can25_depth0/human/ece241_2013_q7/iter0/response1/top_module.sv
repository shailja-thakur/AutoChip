module top_module (
	input clk,
	input j,
	input k,
	output reg Q
);
	
	always @(posedge clk)
	begin
		if (j == 1 && k == 1)
			Q <= ~Q;
		else if (j == 1 && k == 0)
			Q <= 1;
		else if (j == 0 && k == 1)
			Q <= 0;
	end
	
endmodule
