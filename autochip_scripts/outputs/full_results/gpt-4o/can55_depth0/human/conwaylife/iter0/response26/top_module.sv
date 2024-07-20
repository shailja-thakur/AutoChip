module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    // Function to count the neighbors
    function [3:0] count_neighbors;
        input [255:0] grid;
        input [4:0] row;  // 5-bit to accommodate wrapping around 16 positions
        input [4:0] col;  // 5-bit to accommodate wrapping around 16 positions
        integer i, j;
        reg [4:0] r, c;
        integer count;
        begin
            count = 0;
            for (i = -1; i <= 1; i = i + 1) begin
                for (j = -1; j <= 1; j = j + 1) begin
                    if (i != 0 || j != 0) begin
                        r = (row + i) % 16;
                        c = (col + j) % 16;
                        count = count + grid[r*16 + c];
                    end
                end
            end
            count_neighbors = count;
        end
    endfunction

    always @(posedge clk) begin
        integer i, j;
        reg [255:0] next_state;
        if (load) begin
            q <= data;
        end else begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    integer neighbors;
                    neighbors = count_neighbors(q, i, j);
                    if (q[i*16 + j]) begin
                        if (neighbors < 2 || neighbors > 3) begin
                            next_state[i*16 + j] = 0;
                        end else begin
                            next_state[i*16 + j] = 1;
                        end
                    end else begin
                        if (neighbors == 3) begin
                            next_state[i*16 + j] = 1;
                        end else begin
                            next_state[i*16 + j] = 0;
                        end
                    end
                end
            end
            q <= next_state;
        end
    end
endmodule
