module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

	reg [31:0] tap_q;

	always @(posedge clk) begin
		if (reset) begin
			q <= 1'b1;
			tap_q <= 32'h1;
		end else begin
			tap_q <= q;
			q <= {q[31:1], tap_q[22] ^ tap_q[1] ^ tap_q[0] ^ tap_q[31]};
		end
	end

endmodule
