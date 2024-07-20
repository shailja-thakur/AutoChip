module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    integer i, j;

    // Count the number of alive neighbors
    function integer count_neighbors;
        input [255:0] grid;
        input integer x, y;
        integer count, dx, dy, nx, ny;
        begin
            count = 0;
            for (dx = -1; dx <= 1; dx = dx + 1) begin
                for (dy = -1; dy <= 1; dy = dy + 1) begin
                    if (!(dx == 0 && dy == 0)) begin
                        nx = (x + dx + 16) % 16;  // Wrapping around x-axis
                        ny = (y + dy + 16) % 16;  // Wrapping around y-axis
                        count = count + grid[nx * 16 + ny];
                    end
                end
            end
            count_neighbors = count;
        end
    endfunction

    // Update grid based on game rules
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            reg [255:0] new_q;
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    integer neighbors = count_neighbors(q, i, j);
                    if (q[i * 16 + j] == 1) begin
                        if (neighbors < 2 || neighbors > 3) begin
                            new_q[i * 16 + j] = 0;
                        end else begin
                            new_q[i * 16 + j] = 1;
                        end
                    end else begin
                        if (neighbors == 3) new_q[i * 16 + j] = 1;
                        else new_q[i * 16 + j] = 0;
                    end
                end
            end
            q <= new_q;
        end
    end
endmodule
