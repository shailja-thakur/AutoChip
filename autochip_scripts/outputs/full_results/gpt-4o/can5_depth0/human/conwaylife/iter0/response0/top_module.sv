module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] next_q;

    // Function to compute the number of neighbors for a given cell
    function integer count_neighbors;
        input [255:0] grid;
        input integer row, col;
        integer r, c, count;
        begin
            count = 0;
            for (r = -1; r <= 1; r = r + 1) begin
                for (c = -1; c <= 1; c = c + 1) begin
                    if (r != 0 || c != 0) begin
                        // Wrap around using modulo 16
                        count = count + grid[((row + r + 16) % 16) * 16 + ((col + c + 16) % 16)];
                    end
                end
            end
            count_neighbors = count;
        end
    endfunction

    // Compute next state of the game
    integer i, j;
    always @* begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                case (count_neighbors(q, i, j))
                    2: next_q[i * 16 + j] = q[i * 16 + j];  // State does not change if 2 neighbors
                    3: next_q[i * 16 + j] = 1;            // Cell becomes alive if 3 neighbors
                    default: next_q[i * 16 + j] = 0;      // Cell becomes dead otherwise
                endcase
            end
        end
    end

    // Sequential update of the state
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end

endmodule
