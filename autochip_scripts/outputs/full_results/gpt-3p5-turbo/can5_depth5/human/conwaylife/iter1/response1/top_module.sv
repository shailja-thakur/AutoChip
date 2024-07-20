module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);
	
	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			// Variables to hold the next state of each cell
			reg [15:0] next_row [0:15];
			reg [15:0] count;
			
			// Loop through each row of the grid
			// Calculate the next state of each cell based on the current state and its neighbors
			for (int i = 0; i < 16; i = i + 1) begin
				next_row[i] = q[15*i +: 16];
				
				for (int j = 0; j < 16; j = j + 1) begin
					count = 0;
					
					if (q[15*i + j] == 1) begin
						count = count + 1;
					end
					if (q[15*((i+15)%16) + ((j+15)%16)] == 1) begin
						count = count + 1;
					end
					if (q[15*((i+15)%16) + j] == 1) begin
						count = count + 1;
					end
					if (q[15*((i+15)%16) + ((j+1)%16)] == 1) begin
						count = count + 1;
					end
					if (q[15*i + ((j+1)%16)] == 1) begin
						count = count + 1;
					end
					if (q[15*((i+1)%16) + ((j+15)%16)] == 1) begin
						count = count + 1;
					end
					if (q[15*((i+1)%16) + j] == 1) begin
						count = count + 1;
					end
					if (q[15*((i+1)%16) + ((j+1)%16)] == 1) begin
						count = count + 1;
					end
					
					// Update the cell's state based on the count of neighbors
					if (count == 2) begin
						next_row[i][j] = q[15*i + j];
					end else if (count == 3) begin
						next_row[i][j] = 1;
					end else begin
						next_row[i][j] = 0;
					end
				end
			end
			
			// Compose the next state of the game
			for (int i = 0; i < 16; i = i + 1) begin
				q[15*i +: 16] <= next_row[i];
			end
		end
	end
	
endmodule
