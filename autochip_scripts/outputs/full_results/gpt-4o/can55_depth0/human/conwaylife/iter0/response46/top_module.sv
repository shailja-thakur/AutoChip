module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] next_q;
    
    // Function to count the number of neighbors
    function [3:0] count_neighbors(input [255:0] grid, input [4:0] row, input [4:0] col);
        integer r, c;
        reg [3:0] count;
        begin
            count = 0;
            for (r = -1; r <= 1; r = r + 1) begin
                for (c = -1; c <= 1; c = c + 1) begin
                    if (r != 0 || c != 0) begin // Skip the center cell
                        if (grid[{(row + r + 16) % 16, (col + c + 16) % 16}]) begin
                            count = count + 1;
                        end
                    end
                end
            end
            count_neighbors = count;
        end
    endfunction
    
    always @(*) begin
        integer row, col;
        for (row = 0; row < 16; row = row + 1) begin
            for (col = 0; col < 16; col = col + 1) begin
                case (count_neighbors(q, row, col))
                    2: next_q[{row, col}] = q[{row, col}]; // Remain the same
                    3: next_q[{row, col}] = 1;
                    default: next_q[{row, col}] = 0;
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
