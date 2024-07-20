module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);
   
    reg [15:0] grid [15:0]; // 16x16 2D grid
    
    integer i, j;
    
    always @(posedge clk) begin
        if (load) begin
            // Load data into grid
            for (i = 0; i < 16; i = i + 1) begin
                grid[i] <= data[i*16 +: 16];
            end
        end
        else begin
            reg [15:0] new_grid [15:0];
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    // Calculate the number of alive neighbors, considering toroidal wrapping
                    integer n, m, alive_neighbors;
                    alive_neighbors = 0;
                    
                    for (n = -1; n <= 1; n = n + 1) begin
                        for (m = -1; m <= 1; m = m + 1) begin
                            if (n != 0 || m != 0) begin // Exclude the cell itself
                                if (grid[(i + n + 16) % 16][(j + m + 16) % 16]) begin
                                    alive_neighbors = alive_neighbors + 1;
                                end
                            end
                        end
                    end
                    
                    // Determine the state of the cell in the next time step
                    if (alive_neighbors < 2 || alive_neighbors > 3) begin
                        new_grid[i][j] <= 0;
                    end
                    else if (alive_neighbors == 3) begin
                        new_grid[i][j] <= 1;
                    end
                    else begin
                        new_grid[i][j] <= grid[i][j];
                    end
                end
            end
            
            // Update the grid state
            for (i = 0; i < 16; i = i + 1) begin
                grid[i] <= new_grid[i];
            end
        end
        
        // Flatten the grid into a 1D vector q
        for (i = 0; i < 16; i = i + 1) begin
            q[i*16 +: 16] <= grid[i];
        end
    end
endmodule
