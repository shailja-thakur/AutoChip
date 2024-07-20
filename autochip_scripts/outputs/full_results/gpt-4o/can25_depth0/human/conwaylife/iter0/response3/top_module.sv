module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    // Grid dimensions
    localparam N = 16;

    // Index conversion from row/col to linear
    function [7:0] index;
        input [3:0] row, col;
        begin
            index = row * N + col;
        end
    endfunction

    // Count alive neighbours
    function [3:0] count_neighbours;
        input [3:0] row, col;
        integer r, c;
        begin
            count_neighbours = 0;
            for (r = -1; r <= 1; r = r + 1) begin
                for (c = -1; c <= 1; c = c + 1) begin
                    if ((r != 0 || c != 0) &&
                        q[index((row + r + N) % N, (col + c + N) % N)]) begin
                        count_neighbours = count_neighbours + 1;
                    end
                end
            end
        end
    endfunction

    // Update state
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            reg [255:0] next_q;
            integer i, j;
            for (i = 0; i < N; i = i + 1) begin
                for (j = 0; j < N; j = j + 1) begin
                    case (count_neighbours(i, j))
                        0, 1, 4, 5, 6, 7, 8: next_q[index(i, j)] = 0;
                        2: next_q[index(i, j)] = q[index(i, j)];
                        3: next_q[index(i, j)] = 1;
                    endcase
                end
            end
            q <= next_q;
        end
    end

endmodule
