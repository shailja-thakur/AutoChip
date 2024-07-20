module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] q_next; // declare q_next register

	always @(posedge clk) begin
		if (reset) begin
			q <= 32'h1; // reset to initial value
		end else begin
			q <= q_next; // update q register
		end
	end

	always @(q) begin
		q_next[0] = q[31]; // shift q register's value
		q_next[1] = q[0] ^ q[31]; // XOR bit 0 with bit 31
		q_next[21] = q[20] ^ q[0]; // XOR bit 0 with bit 20
		q_next[31] = q[30] ^ q[0]; // XOR bit 0 with bit 30
	end
endmodule
