module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] next_q;

    // Function to count the number of alive neighbors for a given cell (row, col)
    function integer count_neighbors(
        input [255:0] grid,
        input integer row,
        input integer col
    );
        integer i, j;
        integer r, c;
        integer count;
    begin
        count = 0;
        for (i = -1; i <= 1; i = i + 1) begin
            for (j = -1; j <= 1; j = j + 1) begin
                if (i != 0 || j != 0) begin
                    r = (row + i + 16) % 16;
                    c = (col + j + 16) % 16;
                    count = count + grid[r * 16 + c];
                end
            end
        end
        count_neighbors = count;
    end
    endfunction

    always @(*) begin
        integer row, col, neighbors;
        for (row = 0; row < 16; row = row + 1) begin
            for (col = 0; col < 16; col = col + 1) begin
                neighbors = count_neighbors(q, row, col);
                case (neighbors)
                    2: next_q[row * 16 + col] = q[row * 16 + col]; // state does not change
                    3: next_q[row * 16 + col] = 1'b1;              // cell becomes alive
                    default: next_q[row * 16 + col] = 1'b0;        // cell becomes dead
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
