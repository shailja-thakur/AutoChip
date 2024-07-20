module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    integer i, j;
    reg [255:0] q_next;

    // Function to get the state of a cell given its coordinates
    function cell_state;
        input [255:0] q;
        input [4:0] row, col;
        begin
            // Wrap around using modulo 16
            row = row % 16;
            col = col % 16;
            cell_state = q[row * 16 + col];
        end
    endfunction

    // Function to count the number of alive neighbors
    function [3:0] count_neighbors;
        input [255:0] q;
        input [4:0] row, col;
        integer count, r, c;
        begin
            count = 0;
            for (r = -1; r <= 1; r = r + 1) begin
                for (c = -1; c <= 1; c = c + 1) begin
                    if (r != 0 || c != 0) begin
                        count = count + cell_state(q, row + r, col + c);
                    end
                end
            end
            count_neighbors = count;
        end
    endfunction

    always@(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    case (count_neighbors(q, i, j))
                        4'h2: q_next[i*16+j] = q[i*16+j]; // 2 neighbors: Cell state does not change
                        4'h3: q_next[i*16+j] = 1;         // 3 neighbors: Cell becomes 1
                        default: q_next[i*16+j] = 0;      // 0-1 or 4+ neighbors: Cell becomes 0
                    endcase
                end
            end
            q <= q_next;
        end
    end
    
endmodule
