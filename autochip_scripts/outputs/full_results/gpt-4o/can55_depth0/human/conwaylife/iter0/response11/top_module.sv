module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
    );

    reg [15:0][15:0] grid;

    integer i, j;

    // Convert 1D array to 2D grid for easier manipulation
    always @(posedge clk) begin
        if (load) begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    grid[i][j] = data[(i * 16) + j];
                end
            end
            q <= data;
        end else begin
            reg [255:0] next_q;
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    integer count = 0;
                    // Wrapping around the toroid
                    count = count + grid[(i-1) & 4'hf][(j-1) & 4'hf];
                    count = count + grid[(i-1) & 4'hf][j];
                    count = count + grid[(i-1) & 4'hf][(j+1) & 4'hf];
                    count = count + grid[i][(j-1) & 4'hf];
                    count = count + grid[i][(j+1) & 4'hf];
                    count = count + grid[(i+1) & 4'hf][(j-1) & 4'hf];
                    count = count + grid[(i+1) & 4'hf][j];
                    count = count + grid[(i+1) & 4'hf][(j+1) & 4'hf];

                    case (count)
                        2: next_q[(i * 16) + j] = grid[i][j]; // Stay the same
                        3: next_q[(i * 16) + j] = 1;           // Become alive
                        default: next_q[(i * 16) + j] = 0;     // Become dead
                    endcase
                end
            end

            // Update the output state and the grid
            q <= next_q;
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    grid[i][j] = next_q[(i * 16) + j];
                end
            end
        end
    end
endmodule
