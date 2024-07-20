module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	reg [511:0] q_prev; // to store the previous state of the system

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			q_prev <= q; // store the current state in q_prev
			
			// Perform the rule 90 computation
			q[0] <= q_prev[1] ^ q_prev[511];
			for (int i = 1; i < 511; i = i + 1) begin
				q[i] <= q_prev[i-1] ^ q_prev[i+1];
			end
			q[511] <= q_prev[510] ^ q_prev[0];
		end
	end

endmodule
