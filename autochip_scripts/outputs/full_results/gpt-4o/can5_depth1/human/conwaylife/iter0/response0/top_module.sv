module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	reg [15:0] grid [15:0];

	always @(posedge clk) begin
		if(load) begin
			integer i;
			for(i = 0; i < 16; i = i + 1) begin
				grid[i] <= data[i*16 +: 16];
			end
		end else begin
			grid_step();
		end
	end

	task grid_step;
		reg [15:0] new_grid [15:0];
		integer i, j;
		integer ni, nj;
		integer neighbors;
		
		for(i = 0; i < 16; i = i + 1) begin
			for(j = 0; j < 16; j = j + 1) begin
				neighbors = 0;
				for(ni = i-1; ni <= i+1; ni = ni + 1) begin
					for(nj = j-1; nj <= j+1; nj = nj + 1) begin
						if(!(ni == i && nj == j)) begin
							neighbors = neighbors + grid[(ni+16)%16][(nj+16)%16];
						end
					end
				end
				new_grid[i][j] = (neighbors == 3) || (neighbors == 2 && grid[i][j]);
			end
		end

		for(i = 0; i < 16; i = i + 1) begin
			grid[i] = new_grid[i];
		end
	endtask

	always @(posedge clk) begin
		integer k;
		for(k = 0; k < 16; k = k + 1) begin
			q[k*16 +: 16] <= grid[k];
		end
	end

endmodule
