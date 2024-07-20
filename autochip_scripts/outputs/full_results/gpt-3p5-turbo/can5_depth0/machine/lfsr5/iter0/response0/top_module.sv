module top_module(
	input clk,
	input reset,
	output reg [4:0] q);


	reg [4:0] q_next; // next state variable

	always @(q) begin
		q_next[4:1] = q[4:1]; // assign q[4:1] to q_next[4:1]
		q_next[0] = q[4]; // assign q[0] to q_next[4]
		q_next[2] = q_next[2] ^ q[0]; // xor q_next[2] with q[0]
	end

	always @(posedge clk) begin
		if (reset)
			q <= 5'b00001; // assign 5'h1 to q at reset
		else
			q <= q_next; // assign q_next to q
	end

endmodule
