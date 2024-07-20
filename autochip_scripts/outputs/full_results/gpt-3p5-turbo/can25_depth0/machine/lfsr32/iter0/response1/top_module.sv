module top_module(
	input clk,
	input reset,
	output reg [31:0] q);


	reg [31:0] q_next; // declare q_next register

	always @(posedge clk) begin
		if (reset) begin
			q <= 32'h1; // reset to initial value 32'h1
		end else begin
			q <= q_next; // update q register with q_next value
		end
	end

	always @(posedge clk) begin
		// update q_next register on every clock cycle
		q_next[31:0] = {q[30:0], q[0]}; // shift q register by 1 bit
		q_next[21] = q_next[21] ^ q_next[0]; // XOR bit 21 with bit 0
		q_next[1] = q_next[1] ^ q_next[0]; // XOR bit 1 with bit 0
		q_next[0] = q_next[0] ^ q_next[0]; // XOR bit 0 with bit 0
	end
	
endmodule
