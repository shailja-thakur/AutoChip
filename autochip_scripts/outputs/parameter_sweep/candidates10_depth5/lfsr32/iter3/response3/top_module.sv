module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

	reg [31:0] next_q;

	always @(posedge clk or posedge reset)
	begin
		if(reset)
			q <= 32'h1;
		else
		begin
			next_q[0] <= q[31] ^ q[21] ^ q[1] ^ q[0];
			next_q[1] <= q[0] ^ q[31]; // Add XOR with q[31] to next_q[1]
			next_q[2] <= q[1];
			next_q[3:31] <= q[2:30]; // Correct range of bits in assignment
			q <= next_q;
		end
	end
endmodule
