module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [3:0] neighbour_count[15:0][15:0];
    integer i, j;

    // Function to count the number of living neighbours
    function [3:0] count_neighbours;
        input integer row, col;
        integer r, c;
        begin
            count_neighbours = 0;
            for (r = row-1; r <= row+1; r = r + 1) begin
                for (c = col-1; c <= col+1; c = c + 1) begin
                    if (!(r == row && c == col)) begin
                        count_neighbours = count_neighbours + q[((r+16)%16)*16 + ((c+16)%16)];
                    end
                end
            end
        end
    endfunction

    // Main process block
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Calculate neighbours for each cell
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    neighbour_count[i][j] = count_neighbours(i, j);
                end
            end

            // Update state of each cell based on neighbour count
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    case (neighbour_count[i][j])
                        0, 1: q[i*16 + j] <= 0;
                        2: q[i*16 + j] <= q[i*16 + j];
                        3: q[i*16 + j] <= 1;
                        default: q[i*16 + j] <= 0;
                    endcase
                end
            end
        end
    end

endmodule
