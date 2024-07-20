module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);
	
	// Create temporary signals
	reg [511:0] q_temp;
	reg [511:0] q_load;

	always @(posedge clk) begin
		// Load input data if load is high
		if (load) begin
			q_load <= data;
		end
		
		q_temp[0] = q[1] ^ q_load[0] ^ q_load[1];
		
		// Calculate next state for each cell
		for (i = 1; i < 511; i = i + 1) begin
			q_temp[i] = q[i-1] ^ q[i+1] ^ q_load[i];
		end
		
		q_temp[511] = q[510] ^ q_load[511] ^ q_load[510];
		
		// Assign q_temp to q
		q <= q_temp;
	end
	
endmodule
