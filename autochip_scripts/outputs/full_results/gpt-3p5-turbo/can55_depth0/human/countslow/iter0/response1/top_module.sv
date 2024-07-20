module top_module(
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q);
	
	reg [3:0] q_next;
	always @(posedge clk) begin
		if (reset) begin
			q_next <= 4'b0000;
		end else begin
			if (slowena) begin
				q_next <= q + 1;
			end else begin
				q_next <= q;
			end
		end
	end
	always @(posedge clk) begin
		q <= q_next;
	end
	
endmodule
