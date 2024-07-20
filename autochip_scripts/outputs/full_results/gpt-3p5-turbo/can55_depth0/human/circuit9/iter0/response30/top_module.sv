module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);
	
	always @(posedge clk) begin
		if (a) begin
			if (q == 5)
				q = 6;
			else if (q == 6)
				q = 0;
			else if (q == 0)
				q = 1;
			else if (q == 1)
				q = 2;
			else
				q = 3;
		end
	end
	
endmodule
