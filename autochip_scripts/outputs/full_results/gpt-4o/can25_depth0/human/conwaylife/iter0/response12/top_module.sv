module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    // Neighbour Indices
    function [3:0] count_live_neighbours;
        input [255:0] grid;
        input [3:0] i;
        input [3:0] j;
        integer x, y;
        integer ni, nj;
        begin
            count_live_neighbours = 4'd0;
            for (x = -1; x <= 1; x = x + 1) begin
                for (y = -1; y <= 1; y = y + 1) begin
                    // Skip the cell itself
                    if (x != 0 || y != 0) begin
                        ni = (i + x) & 4'hF; // Wrap around using bit masking
                        nj = (j + y) & 4'hF; // Wrap around using bit masking
                        if (grid[ni * 16 + nj] == 1'b1) begin
                            count_live_neighbours = count_live_neighbours + 1;
                        end
                    end
                end
            end
        end
    endfunction

    integer i, j;
    reg [255:0] next_q;

    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                case (count_live_neighbours(q, i, j))
                    0, 1: next_q[i * 16 + j] = 1'b0;   // 0-1 neighbour: Cell becomes 0
                    2: next_q[i * 16 + j] = q[i * 16 + j]; // 2 neighbours: Cell state does not change
                    3: next_q[i * 16 + j] = 1'b1;   // 3 neighbours: Cell becomes 1
                    default: next_q[i * 16 + j] = 1'b0; // 4+ neighbours: Cell becomes 0
                endcase
            end
        end
    end

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end
endmodule
