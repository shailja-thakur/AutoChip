module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] next_q;

	always @(posedge clk) begin
		if (reset) begin
			next_q <= 32'h1;
		end else begin
			next_q <= {q[30:0], q[22]^q[2]^q[1]^q[0]};
		end
	end

	always @(posedge clk) begin
		if (reset) begin
			q <= 32'h1;
		end else begin
			q <= next_q;
		end
	end

endmodule
