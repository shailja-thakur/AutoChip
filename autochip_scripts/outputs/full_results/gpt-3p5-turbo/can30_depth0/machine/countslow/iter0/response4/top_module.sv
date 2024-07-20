module top_module(
	input wire clk,
	input wire slowena,
	input wire reset,
	output reg [3:0] q);
	
	always @(posedge clk) begin
		if (reset) begin
			q <= 4'b0000;
		end else begin
			if (slowena) begin
				if (q == 4'b1001) begin
					q <= 4'b0000;
				end else begin
					q <= q + 4'b0001;
				end
			end
		end
	end
endmodule
