module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	// Internal signal declaration
	reg [4:0] next_q;

	always @(posedge clk, posedge reset) begin
		if (reset)
			next_q <= 5'b1;
		else
			next_q <= {q[3] ^ q[0], q[4:1]};
	end

	always @(posedge clk) begin
		q <= next_q;
	end

endmodule
