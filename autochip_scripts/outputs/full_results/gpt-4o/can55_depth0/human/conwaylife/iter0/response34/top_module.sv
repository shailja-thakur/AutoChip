module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [15:0][15:0] grid;
    reg [15:0][15:0] new_grid;

    // Unpack 256-bit vector into a 16x16 grid
    integer i, j;
    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                grid[i][j] = q[i*16 + j];
            end
        end
    end

    // Compute the next state of the grid
    integer ni, nj, sum;
    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                sum = 0;
                // Sum the number of alive neighbors
                for (ni = -1; ni <= 1; ni = ni + 1) begin
                    for (nj = -1; nj <= 1; nj = nj + 1) begin
                        if (ni != 0 || nj != 0) begin
                            sum = sum + grid[(i+ni+16)%16][(j+nj+16)%16];
                        end
                    end
                end

                // Apply the rules of the game
                if (sum < 2 || sum > 3) begin
                    new_grid[i][j] = 0;
                end
                else if (sum == 3) begin
                    new_grid[i][j] = 1;
                end
                else begin
                    new_grid[i][j] = grid[i][j];
                end
            end
        end
    end

    // Load new data or update the grid state on clock edge
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            // Pack the updated grid back into 256-bit vector
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    q[i*16 + j] <= new_grid[i][j];
                end
            end
        end
    end

endmodule
