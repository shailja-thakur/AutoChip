module top_module(
	input clk,
	input reset,
	output reg [3:0] q);
	
	reg [3:0] next_q;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			next_q <= 4'b0001;
		end else begin
			if (q == 4'b1010) begin
				next_q <= 4'b0001;
			end else begin
				next_q <= q + 1;
			end
		end
	end
	
	always @(posedge clk) begin
		q <= next_q;
	end
	
endmodule
