module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	reg [4:0] q_next;
	
	always @(*) begin
		q_next = q[4:1];            // Assign q next to be q shifted right by 1 bit
		q_next[4] = q[0];           // Assign the 4th bit of q_next to be the 0th bit of q
		q_next[2] = q_next[2] ^ q[0]; // XOR bit 2 with the LSB of q
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 5'h1;              // Assign q to 5'h1 on reset
		end else begin
			q <= q_next;            // Assign q to q_next on positive edge of clk
		end
	end
endmodule
