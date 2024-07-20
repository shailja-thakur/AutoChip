module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

    reg [15:0] grid[15:0]; // Using a 2D array to represent the 16x16 grid

    integer i, j;

    // Initialize the grid
    always @(posedge clk) begin
        if (load) begin
            for (i = 0; i < 16; i = i + 1) begin
                // Load each row of the grid from the data input
                grid[i] <= data[i*16 +: 16];
            end
        end else begin
            // Create a new grid for the next state
            reg [15:0] new_grid[15:0];
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    // Calculate the number of alive neighbors
                    integer x, y;
                    integer alive_neighbors = 0;
                    for (x = -1; x <= 1; x = x + 1) begin
                        for (y = -1; y <= 1; y = y + 1) begin
                            if (x !== 0 || y !== 0) begin
                                if (grid[(i+x+16)%16][(j+y+16)%16]) begin
                                    alive_neighbors = alive_neighbors + 1;
                                end
                            end
                        end
                    end
                    // Update the cell state based on the number of alive neighbors
                    if (alive_neighbors < 2 || alive_neighbors > 3) begin
                        new_grid[i][j] = 0; // Cell dies
                    end else if (alive_neighbors == 3) begin
                        new_grid[i][j] = 1; // Cell becomes alive
                    end else begin
                        new_grid[i][j] = grid[i][j]; // Cell state remains the same
                    end
                end
            end
            // Copy the new grid to the current grid
            for (i = 0; i < 16; i = i + 1) begin
                grid[i] <= new_grid[i];
            end
        end
        // Flatten the grid to the output q
        for (i = 0; i < 16; i = i + 1) begin
            q[i*16 +: 16] <= grid[i];
        end
    end

endmodule
