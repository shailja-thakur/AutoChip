module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [3:0] neighbors [0:255];  // To store the count of neighbors for each cell

    // Function to calculate the number of neighbors of a cell
    function [3:0] count_neighbors;
        input [255:0] grid;
        input integer row, col;
        integer i, j, r, c, idx;
        count_neighbors = 0;
        for (i = -1; i <= 1; i = i + 1) begin
            for (j = -1; j <= 1; j = j + 1) begin
                if (i != 0 || j != 0) begin  // Skip the cell itself
                    r = (row + i + 16) % 16;
                    c = (col + j + 16) % 16;
                    idx = r * 16 + c;
                    count_neighbors = count_neighbors + grid[idx];
                end
            end
        end
    endfunction

    integer row, col, idx;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Calculate the number of neighbors for each cell
            for (row = 0; row < 16; row = row + 1) begin
                for (col = 0; col < 16; col = col + 1) begin
                    idx = row * 16 + col;
                    neighbors[idx] = count_neighbors(q, row, col);
                end
            end

            // Update the state of each cell based on the number of neighbors
            for (row = 0; row < 16; row = row + 1) begin
                for (col = 0; col < 16; col = col + 1) begin
                    idx = row * 16 + col;
                    case (neighbors[idx])
                        0, 1: q[idx] <= 0;
                        2: q[idx] <= q[idx];  // State does not change
                        3: q[idx] <= 1;
                        default: q[idx] <= 0;
                    endcase
                end
            end
        end
    end
endmodule
