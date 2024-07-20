module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [3:0] row, col;
    wire [3:0] prev_row, next_row, prev_col, next_col;
    wire [8:0] neighbors; // Using 8+1 bits, as we will calculate sum of neighbors
    
    // Modulo 16 for wrap-around in both directions
    assign prev_row = (row == 0) ? 15 : row - 1;
    assign next_row = (row == 15) ? 0 : row + 1;
    assign prev_col = (col == 0) ? 15 : col - 1;
    assign next_col = (col == 15) ? 0 : col + 1;
    
    // Calculate the number of alive neighbors
    assign neighbors = q[16*prev_row+prev_col] + q[16*prev_row+col] + q[16*prev_row+next_col] +
                       q[16*row+prev_col]     +                        q[16*row+next_col]     +
                       q[16*next_row+prev_col] + q[16*next_row+col] + q[16*next_row+next_col];
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (row = 0; row < 16; row = row + 1) begin
                for (col = 0; col < 16; col = col + 1) begin
                    case (neighbors)
                        4'b0000, 4'b0001, 4'b0100, 4'b0101, 4'b0110, 4'b0111, 4'b1000: q[16*row+col] <= 0; // 0, 1, 4-8 neighbors: cell becomes 0
                        4'b0010: q[16*row+col] <= q[16*row+col]; // 2 neighbors: state does not change
                        4'b0011: q[16*row+col] <= 1; // 3 neighbors: cell becomes 1 (alive)
                        default: q[16*row+col] <= 0; // Should not happen, adding default to be safe
                    endcase
                end
            end
        end
    end
    
endmodule
