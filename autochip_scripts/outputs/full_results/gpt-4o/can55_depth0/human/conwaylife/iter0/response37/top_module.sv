module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] next_q;

    // Converts 1D index to 2D coordinates
    function [7:0] get_neighbor_idx(input integer x, input integer y, input integer dx, input integer dy);
        begin
            get_neighbor_idx = ((x + dx) % 16) * 16 + ((y + dy) % 16);
        end
    endfunction

    // Counts the number of 1s (alive) in the neighborhood
    function integer count_alive_neighbors(input integer x, input integer y);
        integer count;
        integer dx, dy;
        begin
            count = 0;
            for (dx = -1; dx <= 1; dx = dx + 1) begin
                for (dy = -1; dy <= 1; dy = dy + 1) begin
                    if (!(dx == 0 && dy == 0)) begin
                        if (q[get_neighbor_idx(x, y, dx, dy)]) begin
                            count = count + 1;
                        end
                    end
                end
            end
            count_alive_neighbors = count;
        end
    endfunction

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            integer x, y, neighbors;
            for (x = 0; x < 16; x = x + 1) begin
                for (y = 0; y < 16; y = y + 1) begin
                    neighbors = count_alive_neighbors(x, y);
                    if (neighbors < 2 || neighbors > 3) begin
                        next_q[x * 16 + y] <= 0;
                    end else if (neighbors == 3) begin
                        next_q[x * 16 + y] <= 1;
                    end else begin
                        next_q[x * 16 + y] <= q[x * 16 + y];
                    end
                end
            end
            q <= next_q;
        end
    end

endmodule
