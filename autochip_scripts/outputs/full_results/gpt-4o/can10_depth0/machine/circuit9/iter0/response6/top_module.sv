module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

	// Initial state for q
	initial q = 0;
	
	always @(posedge clk) begin
		if (a == 1)
			q <= 3'd4;
		else if (q == 6)
			q <= 3'd0;
		else
			q <= q + 1;
	end

endmodule
