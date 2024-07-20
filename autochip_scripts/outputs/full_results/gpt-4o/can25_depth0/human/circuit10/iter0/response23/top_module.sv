module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

	always @(posedge clk) begin
		if (a & b) begin
			q <= 0;
		end else if (a & ~b) begin
			q <= ~q;
		end else if (~a & b) begin
			q <= 1;
		end else begin
			q <= q;
		end
		
		state <= q;
	end

endmodule
