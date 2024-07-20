module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [15:0] grid [15:0];
    integer i, j;

    always @(posedge clk) begin
        if (load) begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    grid[i][j] = data[i * 16 + j];
                end
            end
        end else begin
            reg [15:0] new_grid [15:0];
            integer ni, nj;
            integer ni_inv, nj_inv;
            int neighbors;
            
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    neighbors = 0;
                    
                    for (ni = -1; ni <= 1; ni = ni + 1) begin
                        for (nj = -1; nj <= 1; nj = nj + 1) begin
                            if (ni == 0 && nj == 0)
                                continue;

                            ni_inv = (i + ni + 16) % 16;
                            nj_inv = (j + nj + 16) % 16;

                            neighbors = neighbors + grid[ni_inv][nj_inv];
                        end
                    end

                    if (neighbors < 2 || neighbors > 3)
                        new_grid[i][j] <= 0;
                    else if (neighbors == 3)
                        new_grid[i][j] <= 1;
                    else
                        new_grid[i][j] <= grid[i][j];
                end
            end
            
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    grid[i][j] <= new_grid[i][j];
                end
            end
        end
    end
    
    always @* begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                q[i * 16 + j] = grid[i][j];
            end
        end
    end
endmodule
