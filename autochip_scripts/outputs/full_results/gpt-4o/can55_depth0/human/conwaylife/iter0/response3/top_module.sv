module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    // Function to count the number of alive neighbors for cell at (row, col)
    function [3:0] count_neighbors; 
        input [255:0] grid;
        input [3:0] row;
        input [3:0] col;
        integer r, c;
        integer count;
        begin
            count = 0;
            for (r = row-1; r <= row+1; r = r + 1) begin
                for (c = col-1; c <= col+1; c = c + 1) begin
                    if (!(r == row && c == col)) begin
                        count = count + grid[{((r + 16) % 16), ((c + 16) % 16)}];
                    end
                end
            end
            count_neighbors = count;
        end
    endfunction

    // Synchronous process to update the game state
    always @(posedge clk) begin
        if(load) begin
            q <= data;
        end else begin
            reg [255:0] next_q;
            integer i, j;
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    case (count_neighbors(q, i, j))
                        4'b0000, 4'b0001: next_q[{i, j}] = 0;   // 0-1 neighbors: Dead
                        4'b0010: next_q[{i, j}] = q[{i, j}];     // 2 neighbors: No Change
                        4'b0011: next_q[{i, j}] = 1;             // 3 neighbors: Alive
                        default: next_q[{i, j}] = 0;             // 4 or more neighbors: Dead
                    endcase
                end
            end
            q <= next_q;
        end
    end
endmodule
