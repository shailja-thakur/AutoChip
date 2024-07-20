module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    // Calculating the number of neighbours for each cell
    function integer count_neighbors;
        input [255:0] state;
        input integer x, y;
        integer dx, dy, nx, ny, sum;
        begin
            sum = 0;
            for (dx = -1; dx <= 1; dx = dx + 1) begin
                for (dy = -1; dy <= 1; dy = dy + 1) begin
                    if (dx != 0 || dy != 0) begin
                        nx = (x+dx+16) % 16;
                        ny = (y+dy+16) % 16;
                        sum = sum + state[nx*16 + ny];
                    end
                end
            end
            count_neighbors = sum;
        end
    endfunction

    reg [255:0] next_q;
    integer i, j, neighbors;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    neighbors = count_neighbors(q, i, j);
                    if (neighbors < 2 || neighbors > 3)
                        next_q[i*16 + j] = 0;
                    else if (neighbors == 3)
                        next_q[i*16 + j] = 1;
                    else
                        next_q[i*16 + j] = q[i*16 + j];
                end
            end
            q <= next_q;
        end
    end
endmodule
