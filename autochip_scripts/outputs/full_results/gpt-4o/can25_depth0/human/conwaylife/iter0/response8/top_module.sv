module top_module (
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);
    reg [15:0] grid [15:0]; // 16x16 grid as a 2D array
    integer i, j;

    always @(posedge clk) begin
        if (load) begin
            // Load initial state into grid
            for (i = 0; i < 16; i = i + 1) begin
                grid[i] <= data[(i+1)*16-1 -: 16];
            end
        end else begin
            reg [15:0] new_grid [15:0];
            // Compute next state of the grid
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    integer x, y, alive_count;
                    alive_count = 0;

                    // Count alive neighbors
                    for (x = -1; x <= 1; x = x + 1) begin
                        for (y = -1; y <= 1; y = y + 1) begin
                            if (x != 0 || y != 0) begin
                                // Handle toroidal wrapping
                                integer ni = (i + x + 16) % 16;
                                integer nj = (j + y + 16) % 16;
                                if (grid[ni][nj] == 1) alive_count = alive_count + 1;
                            end
                        end
                    end

                    // Apply the rules of the game
                    if (alive_count < 2 || alive_count > 3)
                        new_grid[i][j] = 0;
                    else if (alive_count == 3)
                        new_grid[i][j] = 1;
                    else
                        new_grid[i][j] = grid[i][j]; // Alive count == 2, state stays the same
                end
            end

            // Update the grid
            for (i = 0; i < 16; i = i + 1) begin
                grid[i] <= new_grid[i];
            end
        end
    end

    // Flatten 2D grid to 1D vector output
    always @* begin
        for (i = 0; i < 16; i = i + 1) begin
            q[(i+1)*16-1 -: 16] = grid[i];
        end
    end
endmodule
