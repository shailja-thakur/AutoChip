module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	reg [255:0] q_temp;

	always @(posedge clk) begin
		if (load)
			q <= data;
		else begin
			for (int i = 0; i < 256; i = i + 16) begin
				for (int j = 0; j < 16; j = j + 1) begin
					int num_neighbours = 0;
					
					// Determine number of neighbors for cell (i+j)
					// Check left neighbor
					if (j > 0 && q[i+j-1])
						num_neighbours = num_neighbours + 1;
					
					// Check right neighbor
					if (j < 15 && q[i+j+1])
						num_neighbours = num_neighbours + 1;
					
					// Check above neighbor
					if (i > 15 && q[i+j-16])
						num_neighbours = num_neighbours + 1;
					
					// Check below neighbor
					if (i < 240 && q[i+j+16])
						num_neighbours = num_neighbours + 1;
					
					// Check top left neighbor
					if (i == 0 && j == 0 && q[255])
						num_neighbours = num_neighbours + 1;
					
					// Check top right neighbor
					if (i == 0 && j == 15 && q[j])
						num_neighbours = num_neighbours + 1;
					
					// Check bottom left neighbor
					if (i == 240 && j == 0 && q[255])
						num_neighbours = num_neighbours + 1;
					
					// Check bottom right neighbor
					if (i == 240 && j == 15 && q[i])
						num_neighbours = num_neighbours + 1;

					// Update cell based on number of neighbors
					// (1) 0-1 neighbour: Cell becomes 0.
					// (2) 2 neighbours: Cell state does not change.
					// (3) 3 neighbours: Cell becomes 1.
					// (4) 4+ neighbours: Cell becomes 0.
					if (q_temp[i+j]) begin
						if (num_neighbours == 2 || num_neighbours == 3)
							q[i+j] <= 1;
						else
							q[i+j] <= 0;
					else begin
						if (num_neighbours == 3)
							q[i+j] <= 1;
						else
							q[i+j] <= 0;
					end
				end
			end
		end
	end
endmodule
