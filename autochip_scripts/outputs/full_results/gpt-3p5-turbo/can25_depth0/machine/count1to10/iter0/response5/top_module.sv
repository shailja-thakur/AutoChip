module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	always @(posedge clk) begin
		if(reset) begin
			q <= 4'b0001; // set output register to 1 when reset signal is active
		end else begin
			if(q == 4'b1010) begin
				q <= 4'b0001; // reset output register to 1 when it reaches 10
			end else begin
				q <= q + 1; // increment output register by one
			end
		end
	end
	
endmodule
