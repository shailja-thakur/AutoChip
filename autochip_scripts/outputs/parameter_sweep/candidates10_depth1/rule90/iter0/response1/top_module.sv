module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);
	
	reg [511:0] q_next; // next state of q

	always @(posedge clk) begin
		if (load) begin
			q <= data; // load input data into q
		end else begin
			q <= q_next; // update q with next state
		end
	end
	
	// Generate next state
	always @* begin
		q_next[511] = 0; // boundary condition, q[-1]
		q_next[0] = (q[1] & q[0]) ^ 1; // rule 90
		q_next[511] = (q[511] & q[510]) ^ 0; // rule 90
		for (int i = 1; i < 511; i = i + 1) begin
			q_next[i] = ((q[i-1] & q[i]) & q[i+1]) ^ ((~q[i-1] & ~q[i]) & ~q[i+1]);
		end
	end
endmodule
