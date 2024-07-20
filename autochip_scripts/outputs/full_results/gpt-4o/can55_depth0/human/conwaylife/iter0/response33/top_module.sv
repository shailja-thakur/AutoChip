module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [15:0][15:0] grid;

    // Function to count live neighbors
    function [3:0] count_neighbors(
        input [15:0][15:0] grid,
        input [4:0] x, 
        input [4:0] y);
        integer i, j;
        reg [3:0] count;
        begin
            count = 0;
            for (i = -1; i <= 1; i = i + 1) begin
                for (j = -1; j <= 1; j = j + 1) begin
                    if (i != 0 || j != 0) begin
                        count = count + grid[(x + i + 16) % 16][(y + j + 16) % 16];
                    end
                end
            end
            return count;
        end
    endfunction

    // Convert 1D vector to 2D grid
    function void vector_to_grid(input [255:0] vector, output reg [15:0][15:0] grid);
        integer i, j;
        begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    grid[i][j] = vector[(i * 16) + j];
                end
            end
        end
    endfunction

    // Convert 2D grid to 1D vector
    function [255:0] grid_to_vector(input [15:0][15:0] grid);
        integer i, j;
        reg [255:0] vector;
        begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    vector[(i * 16) + j] = grid[i][j];
                end
            end
            return vector;
        end
    endfunction

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            vector_to_grid(q, grid);
            reg [15:0][15:0] new_grid;
            integer i, j;
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    case (count_neighbors(grid, i, j))
                        4'b0000, 4'b0001: new_grid[i][j] = 0; // 0-1 neighbors: cell dies
                        4'b0010: new_grid[i][j] = grid[i][j]; // 2 neighbors: cell stays the same
                        4'b0011: new_grid[i][j] = 1; // 3 neighbors: cell becomes alive
                        default: new_grid[i][j] = 0; // 4+ neighbors: cell dies
                    endcase
                end
            end
            q <= grid_to_vector(new_grid);
        end
    end
endmodule
