module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [15:0] grid [15:0]; // internal 16x16 grid

    // Initialize the grid
    integer i, j;
    always @(posedge clk) begin
        if (load) begin
            for (i = 0; i < 16; i = i + 1) begin
                grid[i] <= data[(i*16) +: 16];
            end
        end else begin
            reg [15:0] next_grid [15:0];
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    // Count the alive neighbours
                    integer alive_neighbors;
                    alive_neighbors = grid[(i-1) & 4'hf][(j-1) & 4'hf] + grid[(i-1) & 4'hf][j] + grid[(i-1) & 4'hf][(j+1) & 4'hf] +
                                      grid[i][(j-1) & 4'hf]                     +                      grid[i][(j+1) & 4'hf] +
                                      grid[(i+1) & 4'hf][(j-1) & 4'hf] + grid[(i+1) & 4'hf][j] + grid[(i+1) & 4'hf][(j+1) & 4'hf];

                    // Apply the game rules
                    if (grid[i][j] == 1) begin
                        if (alive_neighbors < 2 || alive_neighbors > 3)
                            next_grid[i][j] = 0;
                        else
                            next_grid[i][j] = 1;
                    end else begin
                        if (alive_neighbors == 3)
                            next_grid[i][j] = 1;
                        else
                            next_grid[i][j] = 0;
                    end
                end
            end
            
            // Update the grid
            for (i = 0; i < 16; i = i + 1) begin
                grid[i] <= next_grid[i];
            end
        end

        // Pack the grid into the output vector q
        for (i = 0; i < 16; i = i + 1) begin
            q[(i*16) +: 16] <= grid[i];
        end
    end

endmodule
