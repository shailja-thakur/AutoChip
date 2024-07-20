module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	// Initial block to set the initial value of q
	initial begin
		q = 0;
	end
	
	// Always block triggered on the positive edge of the clock
	always @(posedge clk) begin
		if (reset || q == 4'd9) begin
			q <= 4'd0;
		end else begin
			q <= q + 4'd1;
		end
	end
endmodule
