module top_module(
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q);
	
	reg [3:0] next_q;

	always @(posedge clk) begin
		if (reset) begin
			q <= 4'b0000;
		end else if (slowena) begin
			q <= next_q;
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			next_q <= 4'b0000;
		end else if (slowena) begin
			if (next_q == 4'b1001) begin
				next_q <= 4'b0000;
			end else begin
				next_q <= next_q + 1;
			end
		end
	end

endmodule
