module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    integer i, j;
    reg [8:0] neighbours;

    // Function to compute the number of neighbors
    function [3:0] count_neighbors;
        input [255:0] grid;
        input [4:0] x, y;
        integer ix, iy;
        begin
            count_neighbors = 0;
            for (ix = -1; ix <= 1; ix = ix + 1) begin
                for (iy = -1; iy <= 1; iy = iy + 1) begin
                    if (!(ix == 0 && iy == 0)) begin
                        count_neighbors = count_neighbors + grid[(((x + ix) % 16) + (((y + iy) % 16) * 16)) & 255];
                    end
                end
            end
        end
    endfunction

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            reg [255:0] next_q = 256'd0;
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    neighbours = count_neighbors(q, i, j);
                    if (neighbours == 3 || (neighbours == 2 && q[i * 16 + j])) begin
                        next_q[i * 16 + j] = 1;
                    end else begin
                        next_q[i * 16 + j] = 0;
                    end
                end
            end
            q <= next_q;
        end
    end

endmodule
