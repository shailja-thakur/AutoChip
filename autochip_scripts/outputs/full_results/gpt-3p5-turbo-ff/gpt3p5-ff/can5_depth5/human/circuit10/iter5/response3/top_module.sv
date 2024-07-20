module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

	always @(posedge clk)
	begin
		state <= b & state;
		q <= state ? ~a : q;
	end

endmodule
