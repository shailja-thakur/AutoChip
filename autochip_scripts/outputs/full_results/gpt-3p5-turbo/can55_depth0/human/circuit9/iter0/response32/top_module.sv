module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);
	always @(posedge clk) begin
		if (a == 1) begin
			if (q < 7)
				q <= q + 1;
			else
				q <= 0;
		end
		end
	end
endmodule
