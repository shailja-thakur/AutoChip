module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    integer i, j, row, col, idx;
    reg [3:0] alive_neighbors;

    // Neighbors offsets in the form (row_offset, col_offset)
    integer neighbors[0:7][0:1];

    initial begin
        // Initialize neighbors offsets
        neighbors[0][0] = -1; neighbors[0][1] = -1;
        neighbors[1][0] = -1; neighbors[1][1] =  0;
        neighbors[2][0] = -1; neighbors[2][1] =  1;
        neighbors[3][0] =  0; neighbors[3][1] = -1;
        neighbors[4][0] =  0; neighbors[4][1] =  1;
        neighbors[5][0] =  1; neighbors[5][1] = -1;
        neighbors[6][0] =  1; neighbors[6][1] =  0;
        neighbors[7][0] =  1; neighbors[7][1] =  1;
    end

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            reg [255:0] new_state;
            
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    alive_neighbors = 0;
                    
                    // Count the alive neighbors
                    for (idx = 0; idx < 8; idx = idx + 1) begin
                        row = (i + neighbors[idx][0] + 16) % 16;
                        col = (j + neighbors[idx][1] + 16) % 16;
                        if (q[row * 16 + col]) begin
                            alive_neighbors = alive_neighbors + 1;
                        end
                    end
                    
                    // Apply the rules of the Game of Life
                    case (alive_neighbors)
                        4'h2: new_state[i * 16 + j] = q[i * 16 + j];
                        4'h3: new_state[i * 16 + j] = 1'b1;
                        default: new_state[i * 16 + j] = 1'b0;
                    endcase
                end
            end
            
            q <= new_state;
        end
    end
endmodule
