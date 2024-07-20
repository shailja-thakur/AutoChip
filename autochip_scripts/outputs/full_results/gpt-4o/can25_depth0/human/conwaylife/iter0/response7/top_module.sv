module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

reg [15:0] grid [15:0];
integer i, j;

// Function to count the number of alive neighbors
function [3:0] count_neighbors;
    input [15:0] r0, r1, r2;
    integer    pos;
    reg [2:0] bit_sum;
    begin
        bit_sum = r0[2:1] + r1[2:1] + r2[2:1];
        // Result is incoming one-ring neighborhood from 3 rows by 'shifting' column up and left.
        bit_sum = bit_sum - r1[pos];
        count_neighbors = bit_sum;
    end
endfunction

// Advance state of the game based on current state
always @(posedge clk) begin
    reg [15:0] new_grid [15:0];

    // Initialize new_grid to the current state
    for (i = 0; i < 16; i = i + 1) begin
        new_grid[i] = grid[i];
    end

    if (load) begin
        q <= data;  // Load input data 
    end else begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                reg [3:0] count;
                count = 0;
                count = count_neighbors(
                        grid[(i-1+16)%16][(j-1+16)%16], grid[(i-1+16)%16][j], grid[(i-1+16)%16][(j+1)%16]) +
                        count_neighbors( grid[i][(j-1+16)%16], 0, grid[i][(j+1)%16]) +
                        count_neighbors(grid[(i+1)%16][(j-1+16)%16], grid[(i+1)%16][j], grid[(i+1)%16][(j+1)%16]);

                // Apply the rules of the game
                case (count)
                    4'h2: new_grid[i][j] = grid[i][j];       // No change
                    4'h3: new_grid[i][j] = 1;               // Becomes alive
                    default: new_grid[i][j] = 0;            // Becomes dead
                endcase
            end
        end

        for (i = 0; i < 16; i = i + 1) begin
            grid[i] <= new_grid[i];
        end

        // Pack new grid into a single 256-bit vector
        for (i = 0; i < 16; i = i + 1) begin
            q[i*16 +: 16] <= new_grid[i];
        end
    end
end

// Initialize grid state on load
always @(posedge clk) begin
    if (load) begin
        for (i = 0; i < 16; i = i + 1) begin
            grid[i] <= data[i*16 +: 16];
        end
    end
end

endmodule
