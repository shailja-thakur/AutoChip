module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [15:0] grid [15:0]; // 2D array to represent the grid
    
    integer i, j;
    always @(posedge clk) begin
        if (load) begin
            for (i = 0; i < 16; i = i + 1) begin
                grid[i] <= data[i*16 +: 16];
            end
        end else begin
            reg [15:0] new_grid [15:0];
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    // Compute number of neighbors
                    integer neighbors;
                    neighbors = grid[(i-1+16)%16][(j-1+16)%16] + grid[(i-1+16)%16][j] + grid[(i-1+16)%16][(j+1)%16] +
                                grid[i][(j-1+16)%16]                        + grid[i][(j+1)%16] +
                                grid[(i+1)%16][(j-1+16)%16] + grid[(i+1)%16][j] + grid[(i+1)%16][(j+1)%16];
                    
                    // Apply rules
                    if (neighbors < 2 || neighbors > 3) begin
                        new_grid[i][j] = 0;
                    end else if (neighbors == 3) begin
                        new_grid[i][j] = 1;
                    end else begin
                        new_grid[i][j] = grid[i][j];
                    end
                end
            end
            
            // Update the grid
            for (i = 0; i < 16; i = i + 1) begin
                grid[i] <= new_grid[i];
            end
        end
    end

    // Flatten the 2D grid into 1D vector q
    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin
            q[i*16 +: 16] = grid[i];
        end
    end
    
endmodule
