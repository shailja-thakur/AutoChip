module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);
	always @(posedge clk) begin
		if (a == 1'b1) begin
			if (q == 3'b100)
				q <= 3'b101;
			else if (q == 3'b101)
				q <= 3'b110;
			else
				q <= 3'b000;
		else
			q <= q;
		end
	end
endmodule
