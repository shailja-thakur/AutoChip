module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

	always @(posedge clk) begin
		if (a == 1)
			q <= 3'd4;
		else if (q == 3'd6)
			q <= 3'd0;
		else
			q <= q + 1;
	end

endmodule
