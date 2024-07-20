module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	reg [255:0] next_q;

	always @(posedge clk) begin
		if (load)
			q <= data;
		else
			q <= next_q;
	end

	always @* begin
		foreach(q[i]) begin
			// Calculate the number of live neighbors for each cell
			integer num_neighbors;
			num_neighbors = q[(i+1)%256] + q[(i-1)%256] + q[(i+16)%256] + q[(i-16)%256] + q[(i+17)%256] + q[(i-17)%256] + q[(i+15)%256] + q[(i-15)%256];
			
			// Update the state of each cell based on the number of neighbors
			if (num_neighbors == 3)
				next_q[i] = 1;
			else if (num_neighbors == 2)
				next_q[i] = q[i];
			else
				next_q[i] = 0;
		end
	end

endmodule
