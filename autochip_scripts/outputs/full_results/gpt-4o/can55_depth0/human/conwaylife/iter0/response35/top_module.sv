module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [15:0] grid [15:0]; // 16x16 grid represented as a 2D array

    integer i, j;

    // Function to count the number of alive neighbors
    function [3:0] count_neighbors; 
        input [15:0] grid [15:0];
        input [3:0] x, y;

        reg [3:0] count;
        integer dx, dy;
        begin
            count = 0;
            for (dx = -1; dx <= 1; dx = dx + 1) begin
                for (dy = -1; dy <= 1; dy = dy + 1) begin
                    if (dx !== 0 || dy !== 0) begin
                        if (grid[(x + dx + 16) % 16][(y + dy + 16) % 16]) begin
                            count = count + 1;
                        end
                    end
                end
            end
            count_neighbors = count;
        end
    endfunction

    always @(posedge clk) begin
        if (load) begin
            for (i = 0; i < 16; i = i + 1) begin
                grid[i] <= data[16*i +: 16];
            end
        end else begin
            reg [15:0] new_grid [15:0];
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    case (count_neighbors(grid, i, j))
                        4'd0, 4'd1: new_grid[i][j] = 0;
                        4'd2:       new_grid[i][j] = grid[i][j];
                        4'd3:       new_grid[i][j] = 1;
                        default:    new_grid[i][j] = 0;
                    endcase
                end
            end
            for (i = 0; i < 16; i = i + 1) begin
                grid[i] <= new_grid[i];
            end
        end
        
        // Flatten the grid into the output vector q
        for (i = 0; i < 16; i = i + 1) begin
            q[16*i +: 16] <= grid[i];
        end
    end
endmodule
