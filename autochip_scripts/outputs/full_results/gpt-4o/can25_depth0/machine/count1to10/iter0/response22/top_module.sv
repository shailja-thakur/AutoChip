module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset) 
			q <= 4'b0001; // set q to 1 when reset is active
		else begin
			if (q == 4'b1010) // when q reaches 10 (1010 in binary),
				q <= 4'b0001; // reset q to 1
			else
				q <= q + 1; // otherwise increment q by 1
		end
	end

endmodule
