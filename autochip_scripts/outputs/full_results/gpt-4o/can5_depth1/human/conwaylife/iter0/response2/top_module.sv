module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    wire [3:0] neighbours_count [0:255];
    reg [3:0] row, col;
    wire [15:0] current_row [0:15];
    
    // Split the 256-bit vector into 16 rows of 16-bit for easier indexing
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin: split_rows
            assign current_row[i] = q[16*i +: 16];
        end
    endgenerate

    // Function to count the number of live neighbours
    function [3:0] count_neighbours;
        input [15:0] grid [0:15];
        input [3:0] r, c;
        integer dr, dc;
        integer nr, nc;
        begin
            count_neighbours = 0;
            for (dr = -1; dr <= 1; dr = dr + 1) begin
                for (dc = -1; dc <= 1; dc = dc + 1) begin
                    if (dr != 0 || dc != 0) begin
                        nr = (r + dr + 16)%16;
                        nc = (c + dc + 16)%16;
                        count_neighbours = count_neighbours + grid[nr][nc];
                    end
                end
            end
        end
    endfunction

    // Calculate the number of neighbours for each cell
    always @(*) begin
        for (row = 0; row < 16; row = row + 1) begin
            for (col = 0; col < 16; col = col + 1) begin
                neighbours_count[row*16 + col] = count_neighbours(current_row, row, col);
            end
        end
    end
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            for (row = 0; row < 16; row = row + 1) begin
                for (col = 0; col < 16; col = col + 1) begin
                    case (neighbours_count[row*16 + col])
                        4'd2: q[row*16 + col] <= q[row*16 + col];  // State remains the same
                        4'd3: q[row*16 + col] <= 1'b1;  // Become alive
                        default: q[row*16 + col] <= 1'b0;  // Become dead
                    endcase
                end
            end
        end
    end
endmodule
