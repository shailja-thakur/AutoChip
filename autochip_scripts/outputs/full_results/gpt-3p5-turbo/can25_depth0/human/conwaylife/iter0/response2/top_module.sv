module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);
	
	reg [255:0] q_temp; // Temporary variable to hold the next state of q
	
	// Register to hold the current state of q
	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			q <= q_temp;
		end
	end
	
	// Assign statement to calculate the next state of q
	always @* begin
		for (integer i = 0; i < 256; i = i + 1) begin
			integer row = i / 16;
			integer col = i % 16;
			integer n_count = 0;
			
			// Calculate the number of neighbors for each cell
			if (q[((row+15)%16)*16 + ((col+15)%16)])     n_count = n_count + 1;
			if (q[((row+15)%16)*16 + col])               n_count = n_count + 1;
			if (q[((row+15)%16)*16 + ((col+1)%16)])      n_count = n_count + 1;
			if (q[row*16 + ((col+15)%16)])               n_count = n_count + 1;
			if (q[row*16 + ((col+1)%16)])                n_count = n_count + 1;
			if (q[((row+1)%16)*16 + ((col+15)%16)])      n_count = n_count + 1;
			if (q[((row+1)%16)*16 + col])                n_count = n_count + 1;
			if (q[((row+1)%16)*16 + ((col+1)%16)])       n_count = n_count + 1;
			
			// Calculate the next state of each cell based on the number of neighbors
			if (n_count == 2) begin
				q_temp[i] = q[i];
			end else begin
				if (n_count == 3) begin
					q_temp[i] = 1;
				end else begin
					q_temp[i] = 0;
				end
			end
		end
	end
	
endmodule
