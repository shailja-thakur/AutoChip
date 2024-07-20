module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [15:0] grid[15:0];
    reg [15:0] next_grid[15:0];

    integer i, j, ni, nj, count;

    // load the initial state
    always @(posedge clk) begin
        if (load) begin
            for (i = 0; i < 16; i = i + 1)
                grid[i] <= data[i * 16 +: 16];
        end else begin
            // Calculate the next state
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    count = 0;

                    // Count the number of alive neighbors
                    for (ni = -1; ni <= 1; ni = ni + 1) begin
                        for (nj = -1; nj <= 1; nj = nj + 1) begin
                            if (!(ni == 0 && nj == 0)) begin
                                if (grid[(i + ni + 16) % 16][(j + nj + 16) % 16])
                                    count = count + 1;
                            end
                        end
                    end
                    
                    // Update the cell state based on the rules
                    if (grid[i][j] == 1) begin
                        if (count == 2 || count == 3)
                            next_grid[i][j] = 1;
                        else
                            next_grid[i][j] = 0;
                    end else begin
                        if (count == 3)
                            next_grid[i][j] = 1;
                        else
                            next_grid[i][j] = 0;
                    end
                end
            end

            // Update the current grid state
            for (i = 0; i < 16; i = i + 1)
                grid[i] <= next_grid[i];
        end
    end
    
    // Output the current state
    always @(*) begin
        for (i = 0; i < 16; i = i + 1)
            q[i * 16 +: 16] = grid[i];
    end
    
endmodule
