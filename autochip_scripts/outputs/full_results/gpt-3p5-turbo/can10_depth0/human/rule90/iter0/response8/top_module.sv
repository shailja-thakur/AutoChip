module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);
	
	// Internal signals
	reg [511:0] q_reg;
	
	// Assign current state of q to q_reg
	always @(posedge clk) begin
		if (load)
			q_reg <= data;
		else
			q_reg <= q;
	end
	
	// Update the next state based on current state
	always @(posedge clk) begin
		q[0] <= (q_reg[1] ^ q_reg[0]);
		for (int i = 1; i < 511; i = i+1) begin
			q[i] <= (q_reg[i+1] ^ q_reg[i-1]);
		end
		q[511] <= (q_reg[511] ^ q_reg[510]);
	end
	
endmodule
