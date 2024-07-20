module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    integer i, j, count;
    reg [15:0] grid [15:0];
    reg [15:0] temp_grid [15:0];
    
    // Convert the 256-bit vector to 16x16 grid for easier handling
    always @(posedge clk) begin
        if (load) begin
            for (i = 0; i < 16; i = i + 1) begin
                grid[i] = data[i*16 +: 16];
            end
        end else begin
            // Update the grid state
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    count = 0;
                    // Count the number of alive neighbours
                    count = grid[(i + 15) % 16][(j + 15) % 16] + 
                            grid[(i + 15) % 16][j] + 
                            grid[(i + 15) % 16][(j + 1) % 16] + 
                            grid[i][(j + 15) % 16] + 
                            grid[i][(j + 1) % 16] + 
                            grid[(i + 1) % 16][(j + 15) % 16] + 
                            grid[(i + 1) % 16][j] + 
                            grid[(i + 1) % 16][(j + 1) % 16];
                    
                    // Apply the rules of the game
                    if (count < 2 || count > 3)
                        temp_grid[i][j] = 0;
                    else if (count == 3)
                        temp_grid[i][j] = 1;
                    else
                        temp_grid[i][j] = grid[i][j];
                end
            end

            // Update the grid with new state
            for (i = 0; i < 16; i = i + 1) begin
                grid[i] = temp_grid[i];
            end
        end
        
        // Convert the grid back to the 256-bit vector
        for (i = 0; i < 16; i = i + 1) begin
            q[i*16 +: 16] = grid[i];
        end
    end
endmodule
