module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	always @(posedge clk) begin
		if (reset) begin
			q <= 32'h1;
		end else begin
			q <= {q[31:1], q[22]^q[1]^q[0]^q[31]};
		end
	end
endmodule
