module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    integer i, j;
    reg [15:0] grid [15:0];
    reg [15:0] new_grid [15:0];
    integer ni, nj;
    integer count;

    // Convert the 1D data array into a 2D grid
    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin
            grid[i] = data[i * 16 +: 16];
        end
    end

    // Process the grid on each clock cycle
    always @(posedge clk) begin
        if (load) begin
            // Load initial state into q
            q <= data;
        end else begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    // Count alive neighbours
                    count = 0;
                    for (ni = -1; ni <= 1; ni = ni + 1) begin
                        for (nj = -1; nj <= 1; nj = nj + 1) begin
                            if (!(ni == 0 && nj == 0)) begin
                                count = count + grid[(i + ni + 16) % 16][(j + nj + 16) % 16];
                            end
                        end
                    end

                    // Apply rules
                    if (count < 2 || count > 3) begin
                        new_grid[i][j] = 0;
                    end else if (count == 3) begin
                        new_grid[i][j] = 1;
                    end else begin // count == 2
                        new_grid[i][j] = grid[i][j];
                    end
                end
            end

            // Convert the 2D new_grid to a 1D array and assign to q
            for (i = 0; i < 16; i = i + 1) begin
                q[i * 16 +: 16] = new_grid[i];
            end
        end
    end
endmodule
