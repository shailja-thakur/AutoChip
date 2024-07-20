module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);
    
    integer i, j;

    reg [255:0] next_state;
    wire [15:0] grid [15:0];

    // Unflatten the grid for easier access
    generate
        genvar idx;
        for (idx = 0; idx < 16; idx = idx + 1) begin: unflatten
            assign grid[idx] = q[idx * 16 +: 16];
        end
    endgenerate

    // Flatten the grid back to a single 256-bit vector
    generate
        for (idx = 0; idx < 16; idx = idx + 1) begin: flatten
            always @(*) begin
                next_state[idx * 16 +: 16] = grid[idx];
            end
        end
    endgenerate

    // Find the number of neighbors for a given cell
    function [3:0] count_neighbours (
        input integer row,
        input integer col
    );
        integer r_offset, c_offset;
        integer r, c;
        begin
            count_neighbours = 0;
            for (r_offset = -1; r_offset <= 1; r_offset = r_offset + 1) begin
                for (c_offset = -1; c_offset <= 1; c_offset = c_offset + 1) begin
                    // Wrap around the edges
                    r = (row + r_offset + 16) % 16;
                    c = (col + c_offset + 16) % 16;
                    if (!(r_offset == 0 && c_offset == 0) && grid[r][c])
                        count_neighbours = count_neighbours + 1;
                end
            end
        end
    endfunction

    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                case (count_neighbours(i, j))
                    4'b0000, 4'b0001, 4'b0100, 4'b0101, 4'b0110, 4'b0111, 4'b1000 : next_state[i * 16 + j] = 0;
                    4'b0010: next_state[i * 16 + j] = grid[i][j];
                    4'b0011: next_state[i * 16 + j] = 1;
                    default: next_state[i * 16 + j] = 0;
                endcase
            end
        end
    end

    // Update the q vector
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_state;
        end
    end

endmodule
