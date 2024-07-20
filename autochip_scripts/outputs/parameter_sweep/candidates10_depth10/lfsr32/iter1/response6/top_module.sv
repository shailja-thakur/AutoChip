module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] q_next;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 32'h1;
		end else begin
			q_next = {q[30:0], q[22]^q[2]^q[1]};
			q <= q_next;
		end
	end
endmodule
