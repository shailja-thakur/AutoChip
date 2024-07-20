module top_module (
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);
    // Helper function to count the number of alive neighbours
    function [3:0] count_neighbours;
        input [255:0] grid;
        input [3:0] row;
        input [3:0] col;
        integer r, c;
        integer count;
        begin
            count = 0;
            for (r = -1; r <= 1; r = r + 1) begin
                for (c = -1; c <= 1; c = c + 1) begin
                    if (r != 0 || c != 0) begin // skip the cell itself
                        count = count + grid[16 * ((row + r) & 4'hf) + ((col + c) & 4'hf)];
                    end
                end
            end
            count_neighbours = count;
        end
    endfunction
    
    reg [255:0] next_q;
    integer i, j;
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    case (count_neighbours(q, i, j))
                        4'h2: next_q[16*i + j] = q[16*i + j];      // 2 neighbours: stasis
                        4'h3: next_q[16*i + j] = 1'b1;             // 3 neighbours: cell becomes alive
                        default: next_q[16*i + j] = 1'b0;          // 0-1 or 4+ neighbours: cell becomes dead
                    endcase
                end
            end
            q <= next_q;
        end
    end
endmodule
