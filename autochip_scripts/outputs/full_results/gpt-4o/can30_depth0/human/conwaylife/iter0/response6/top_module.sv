module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    integer i, j;

    // Function to get the state of the cell with wrapping around edges
    function [0:0] get_cell;
        input [255:0] grid;
        input integer row, col;
        begin
            row = (row + 16) % 16;
            col = (col + 16) % 16;
            get_cell = grid[row * 16 + col];
        end
    endfunction

    // Function to count the number of alive neighbours
    function [3:0] count_neighbours;
        input [255:0] grid;
        input integer row, col;
        integer dr, dc;
        begin
            count_neighbours = 0;
            for (dr = -1; dr <= 1; dr = dr + 1) begin
                for (dc = -1; dc <= 1; dc = dc + 1) begin
                    if (dr != 0 || dc != 0) begin
                        count_neighbours = count_neighbours + get_cell(grid, row + dr, col + dc);
                    end
                end
            end
        end
    endfunction

    // Compute the next state of the grid
    reg [255:0] next_q;
    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                case (count_neighbours(q, i, j))
                    4'd2: next_q[i * 16 + j] = q[i * 16 + j];
                    4'd3: next_q[i * 16 + j] = 1'b1;
                    default: next_q[i * 16 + j] = 1'b0;
                endcase
            end
        end
    end

    // Update the state of the grid on the clock edge
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end

endmodule
