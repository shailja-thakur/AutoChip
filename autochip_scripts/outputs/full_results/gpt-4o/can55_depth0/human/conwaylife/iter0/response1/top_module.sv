module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] next_q;
    integer i, j;

    // Function to count the number of alive neighbors
    function [3:0] count_neighbors;
        input [15:0] row;
        input [15:0] col;
        input [255:0] state;
        integer r, c;
        begin
            count_neighbors = 0;
            for (r = -1; r <= 1; r = r + 1) begin
                for (c = -1; c <= 1; c = c + 1) begin
                    if (r != 0 || c != 0) begin
                        if (state[((row + 16 + r) % 16) * 16 + ((col + 16 + c) % 16)] == 1) begin
                            count_neighbors = count_neighbors + 1;
                        end
                    end
                end
            end
        end
    endfunction

    always @(posedge clk) begin
        if (load) begin
            q <= data; // Load initial state
        end else begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    case (count_neighbors(i, j, q))
                        4'd0, 4'd1, 4'd4, 4'd5, 4'd6, 4'd7, 4'd8: next_q[i * 16 + j] = 0; // 0-1 or 4+ neighbors: cell becomes dead
                        4'd2: next_q[i * 16 + j] = q[i * 16 + j]; // 2 neighbors: cell state does not change
                        4'd3: next_q[i * 16 + j] = 1; // 3 neighbors: cell becomes alive
                    endcase
                end
            end
            q <= next_q; // Update state
        end
    end
endmodule
