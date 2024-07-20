module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [15:0][15:0] grid;

    // Update the grid every clock cycle
    always @(posedge clk) begin
        integer i, j, ni, nj, count;
        reg [15:0][15:0] new_grid;

        if (load) begin
            // Load the data into the grid
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    grid[i][j] = data[i * 16 + j];
                end
            end
        end else begin
            // Process the game of life rules on each cell
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    count = 0;
                    // Calculate the number of alive neighbors
                    for (ni = -1; ni <= 1; ni = ni + 1) begin
                        for (nj = -1; nj <= 1; nj = nj + 1) begin
                            if (ni != 0 || nj != 0) begin
                                count = count + grid[(i + ni + 16) % 16][(j + nj + 16) % 16];
                            end
                        end
                    end
                    // Apply the rules to the cell
                    case (count)
                        2: new_grid[i][j] = grid[i][j];
                        3: new_grid[i][j] = 1;
                        default: new_grid[i][j] = 0;
                    endcase
                end
            end

            // Update the grid state
            grid = new_grid;
        end

        // Flatten the grid into the output vector q
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                q[i * 16 + j] = grid[i][j];
            end
        end
    end

endmodule
