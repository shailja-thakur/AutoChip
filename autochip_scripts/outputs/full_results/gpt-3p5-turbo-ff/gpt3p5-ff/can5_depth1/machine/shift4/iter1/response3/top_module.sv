module top_module(
	input clk,
	input areset,
	input load,
	input ena,
	input [3:0] data,
	output reg [3:0] q);

	reg [3:0] next_q;

	always @(posedge clk or posedge areset) begin
		if (areset)
			next_q <= 4'b0;
		else if (load)
			next_q <= data;
		else if (ena)
			next_q <= {q[2:0], 1'b0};
		else
			next_q <= q;
	end

	always @(posedge clk) begin
		if (areset)
			q <= 4'b0;
		else
			q <= next_q;
	end

endmodule
