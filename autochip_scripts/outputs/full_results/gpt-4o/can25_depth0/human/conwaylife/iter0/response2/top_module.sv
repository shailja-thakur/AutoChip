module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    // Task to count alive neighbours with wrapping around (torus)
    function [3:0] count_alive_neighbours;
        input [255:0] grid;
        input [4:0] x;
        input [4:0] y;
        integer dx, dy;
        reg [3:0] count;
        begin
            count = 0;
            for (dx = -1; dx <= 1; dx = dx + 1) begin
                for (dy = -1; dy <= 1; dy = dy + 1) begin
                    if (dx != 0 || dy != 0) begin
                        if (grid[((16 + ((x + dx) % 16)) % 16) * 16 + ((16 + ((y + dy) % 16)) % 16)])
                            count = count + 1;
                    end
                end
            end
            count_alive_neighbours = count;
        end
    endfunction

    integer i, j;
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            reg [255:0] next_state;
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    case (count_alive_neighbours(q, i, j))
                        4'b0000, 4'b0001: next_state[i * 16 + j] = 0; // 0-1 neighbours
                        4'b0010:          next_state[i * 16 + j] = q[i * 16 + j]; // 2 neighbours
                        4'b0011:          next_state[i * 16 + j] = 1; // 3 neighbours
                        default:          next_state[i * 16 + j] = 0; // 4+ neighbours
                    endcase
                end
            end
            q <= next_state;
        end
    end
endmodule
