module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

	always @(posedge clk) begin
		if (a == 1) begin
			q <= 3'd4;
		end
		else begin
			if (q == 3'd4) begin
				q <= 3'd5;
			end
			else if (q == 3'd5) begin
				q <= 3'd6;
			end
			else if (q == 3'd6) begin
				q <= 3'd0;
			end
			else if (q == 3'd0) begin
				q <= 3'd1;
			end
			else if (q == 3'd1) begin
				q <= 3'd4;
			end
		end
	end
	
endmodule
