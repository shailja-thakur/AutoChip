module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);
	
	// Internal signals
	reg [511:0] q_next;
	
	// Rule 110 table
	parameter [7:0] rule_table = 8'b01101110;
	
	// Assign next state based on Rule 110 table
	always @* begin
		for (int i = 0; i < 512; i = i + 1) begin
			if (i == 0)
				q_next[i] = rule_table[{q[i+1], q[i], 1'b0}];
			else if (i == 511)
				q_next[i] = rule_table[{q[i], 1'b0, q[i-1]}];
			else
				q_next[i] = rule_table[{q[i+1], q[i], q[i-1]}];
		end
	end
	
	// Load q with data when load is high
	always @(posedge clk) begin
		if (load)
			q <= data;
		else
			q <= q_next;
	end
	
endmodule
