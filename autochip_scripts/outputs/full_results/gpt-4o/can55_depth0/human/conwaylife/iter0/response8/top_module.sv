module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] next_q;
    
    integer x, y;
    
    // Function to compute the number of alive neighbors
    function [3:0] count_neighbors;
        input [255:0] grid;
        input integer row, col;
        integer r, c;
        begin
            count_neighbors = 0;
            for (r = -1; r <= 1; r = r + 1) begin
                for (c = -1; c <= 1; c = c + 1) begin
                    if (!(r == 0 && c == 0)) begin
                        // Wrap around in toroidal fashion
                        count_neighbors = count_neighbors + grid[16 * ((row + r + 16) % 16) + ((col + c + 16) % 16)];
                    end
                end
            end
        end
    endfunction
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (x = 0; x < 16; x = x + 1) begin
                for (y = 0; y < 16; y = y + 1) begin
                    case (count_neighbors(q, x, y))
                        4'd2: next_q[16 * x + y] = q[16 * x + y]; // Stay the same
                        4'd3: next_q[16 * x + y] = 1;             // Becomes alive
                        default: next_q[16 * x + y] = 0;          // Becomes dead
                    endcase
                end
            end
            q <= next_q;
        end
    end
endmodule
