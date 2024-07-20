module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [15:0] grid [15:0]; // 16x16 grid

// Unroll the 1D data array into the 2D grid array
integer i, j;
always @(posedge clk) begin
    if (load) begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                grid[i][j] <= data[i * 16 + j];
            end
        end
    end else begin
        reg [15:0] new_grid [15:0];
        
        // Calculate new state for each cell
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                integer alive_neighbours;
                alive_neighbours = 0;
                // Check all 8 neighbours, with wrap-around
                alive_neighbours = grid[(i+15)%16][(j+15)%16] + grid[(i+15)%16][j] + grid[(i+15)%16][(j+1)%16] +
                                   grid[i][(j+15)%16]                      + grid[i][(j+1)%16] +
                                   grid[(i+1)%16][(j+15)%16] + grid[(i+1)%16][j] + grid[(i+1)%16][(j+1)%16];
                                   
                // Apply the rules
                if (alive_neighbours < 2 || alive_neighbours > 3) begin
                    new_grid[i][j] = 0;
                end else if (alive_neighbours == 3) begin
                    new_grid[i][j] = 1;
                end else begin
                    new_grid[i][j] = grid[i][j];
                end
            end
        end
        
        // Update the grid
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                grid[i][j] <= new_grid[i][j];
            end
        end
    end
end

// Pack the 2D grid array back into the 1D q array
always @(*) begin
    for (i = 0; i < 16; i = i + 1) begin
        for (j = 0; j < 16; j = j + 1) begin
            q[i * 16 + j] = grid[i][j];
        end
    end
end

endmodule
