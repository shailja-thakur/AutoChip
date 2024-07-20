module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] next_state;

    // Function to calculate the number of neighbors
    function [3:0] count_neighbors;
        input [255:0] grid;
        input [4:0] x;
        input [4:0] y;
        integer count;
        integer i, j;
        
        begin
            count = 0;
            for (i = -1; i <= 1; i = i + 1) begin
                for (j = -1; j <= 1; j = j + 1) begin
                    if (i != 0 || j != 0) begin
                        count = count + grid[((y + i) & 4'hf) * 16 + ((x + j) & 4'hf)];
                    end
                end
            end
            count_neighbors = count;
        end
    endfunction

    // Function to calculate the next state of a cell
    function cell_next_state;
        input [255:0] grid;
        input [4:0] x;
        input [4:0] y;
        reg [3:0] neighbors;
        
        begin
            neighbors = count_neighbors(grid, x, y);
            if (neighbors < 2 || neighbors > 3) begin
                cell_next_state = 0;
            end else if (neighbors == 3) begin
                cell_next_state = 1;
            end else begin
                cell_next_state = grid[y * 16 + x];
            end
        end
    endfunction

    // Calculate the next state for the entire grid
    integer ix, iy;
    always @(*) begin
        for (iy = 0; iy < 16; iy = iy + 1) begin
            for (ix = 0; ix < 16; ix = ix + 1) begin
                next_state[iy * 16 + ix] = cell_next_state(q, ix, iy);
            end
        end
    end

    // Register logic for the next state
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_state;
        end
    end

endmodule
