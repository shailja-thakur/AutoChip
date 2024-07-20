module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    // Generate the coordinate of the neighbors of a cell taking into account the toroidal wrapping
    function [8*4-1:0] get_neighbors;
        input integer row, col;
        integer r, c, i;
        begin
            i = 0;
            for (r = -1; r <= 1; r = r + 1) begin
                for (c = -1; c <= 1; c = c + 1) begin
                    if (r != 0 || c != 0) begin // skip the cell itself
                        get_neighbors[i*4 +: 4] = ((row + r + 16) % 16) * 16 + (col + c + 16) % 16;
                        i = i + 1;
                    end
                end
            end
        end
    endfunction

    // Calculate the next state for a cell based on its neighbors
    function get_next_state;
        input integer row, col;
        input [255:0] grid;
        integer i, neighbors;
        begin
            neighbors = 0;
            for (i = 0; i < 8; i = i + 1) begin
                neighbors = neighbors + grid[get_neighbors(row, col)[i*4 +: 4]];
            end

            if (neighbors == 3 || (grid[row * 16 + col] && neighbors == 2)) begin
                get_next_state = 1;
            end else begin
                get_next_state = 0;
            end
        end
    endfunction

    integer row, col;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (row = 0; row < 16; row = row + 1) begin
                for (col = 0; col < 16; col = col + 1) begin
                    q[row * 16 + col] <= get_next_state(row, col, q);
                end
            end
        end
    end
endmodule
