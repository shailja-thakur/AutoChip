module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [15:0] grid [15:0]; // 16x16 grid representation
reg [15:0] next_grid [15:0];

// Helper function to count neighbors
function integer count_neighbors(input [15:0] g [15:0], input integer x, input integer y);
    integer i, j, count;
    begin
        count = 0;
        for (i = -1; i <= 1; i = i + 1) begin
            for (j = -1; j <= 1; j = j + 1) begin
                if (!(i == 0 && j == 0)) begin
                    count = count + g[(x + i + 16) % 16][(y + j + 16) % 16];
                end
            end
        end
        count_neighbors = count;
    end
endfunction

// Load initial state logic
always @(posedge clk) begin
    if (load) begin
        integer i, j;
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                grid[i][j] = data[i * 16 + j];
            end
        end
    end
end

// Update state logic on each clock cycle
always @(posedge clk) begin
    if (!load) begin
        integer x, y, neighbors;
        for (x = 0; x < 16; x = x + 1) begin
            for (y = 0; y < 16; y = y + 1) begin
                neighbors = count_neighbors(grid, x, y);
                if (neighbors < 2 || neighbors > 3)
                    next_grid[x][y] = 0;
                else if (neighbors == 3)
                    next_grid[x][y] = 1;
                else
                    next_grid[x][y] = grid[x][y];
            end
        end

        // Update grid state
        for (x = 0; x < 16; x = x + 1) begin
            for (y = 0; y < 16; y = y + 1) begin
                grid[x][y] = next_grid[x][y];
            end
        end
    end

    // Output the state as a 256bit vector
    integer k;
    for (k = 0; k < 256; k = k + 1) begin
        q[k] = grid[k / 16][k % 16];
    end
end

endmodule
