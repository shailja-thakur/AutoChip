module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    integer i, j, ni, nj;
    wire [15:0] row [15:0];
    reg [3:0] neighbors;
    
    // Some helper functions to calculate row and column indices for neighbors considering toroid wrapping
    function [3:0] count_neighbors;
        input integer x, y;
        integer i, j, ni, nj;
        begin
            count_neighbors = 0; 
            // Iterate over the 3x3 neighborhood centered at (x, y)
            for (i = -1; i <= 1; i = i + 1) begin
                for (j = -1; j <= 1; j = j + 1) begin
                    if (i != 0 || j != 0) begin // Do not count the cell itself
                        ni = (x + i + 16) % 16; // Wrap around row index
                        nj = (y + j + 16) % 16; // Wrap around column index
                        count_neighbors = count_neighbors + row[ni][nj];
                    end
                end
            end
        end
    endfunction

    // Separate the 256-bit input data into 16x16 matrix (row-wise)
    generate
        genvar r;
        for (r = 0; r < 16; r = r + 1) begin : ROW_GEN
            assign row[r] = q[r * 16 +: 16];
        end
    endgenerate

    always @(posedge clk) begin
        if (load) begin
            // Loading initial state into q
            q <= data;
        end else begin
            // Compute next state of the game
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    neighbors = count_neighbors(i, j);
                    // Game of life rules
                    case (neighbors)
                        4'b0010: q[i * 16 + j] <= q[i * 16 + j]; // 2 neighbors, state stays the same
                        4'b0011: q[i * 16 + j] <= 1; // 3 neighbors, state becomes 1
                        default: q[i * 16 + j] <= 0; // Otherwise, state becomes 0
                    endcase
                end
            end
        end
    end
endmodule
