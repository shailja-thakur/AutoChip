module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    wire [3:0] neighbors [0:255];
    
    integer i, j, k, l;
    
    // Helper function to count alive neighbors
    function [3:0] count_neighbors;
        input integer row;
        input integer col;
        integer r, c;
        begin
            count_neighbors = 0;
            for (r = row - 1; r <= row + 1; r = r + 1) begin
                for (c = col - 1; c <= col + 1; c = c + 1) begin
                    if (r != row || c != col) begin
                        count_neighbors = count_neighbors + q[((r + 16) % 16)*16 + ((c + 16) % 16)];
                    end
                end
            end
        end
    endfunction
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Calculate number of neighbors for each cell
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    neighbors[i*16 + j] = count_neighbors(i, j);
                end
            end
            
            // Update the state of each cell based on the game rules
            for (k = 0; k < 16; k = k + 1) begin
                for (l = 0; l < 16; l = l + 1) begin
                    case (neighbors[k*16 + l])
                        2: q[k*16 + l] <= q[k*16 + l]; // State does not change
                        3: q[k*16 + l] <= 1; // Cell becomes alive
                        default: q[k*16 + l] <= 0; // Cell becomes dead
                    endcase
                end
            end
        end
    end

endmodule
