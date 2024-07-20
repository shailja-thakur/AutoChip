module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [15:0][15:0] grid;

    integer i, j;
    
    always @(posedge clk) begin
        if (load) begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    grid[i][j] = data[i * 16 + j];
                end
            end
            q <= data;
        end
        else begin
            reg [15:0][15:0] next_grid;
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    integer alive_neighbors;
                    alive_neighbors = grid[(i+15)%16][(j+15)%16] +
                                      grid[(i+15)%16][j] +
                                      grid[(i+15)%16][(j+1)%16] +
                                      grid[i][(j+15)%16] +
                                      grid[i][(j+1)%16] +
                                      grid[(i+1)%16][(j+15)%16] +
                                      grid[(i+1)%16][j] +
                                      grid[(i+1)%16][(j+1)%16];

                    if (alive_neighbors == 2)
                        next_grid[i][j] = grid[i][j];
                    else if (alive_neighbors == 3)
                        next_grid[i][j] = 1;
                    else
                        next_grid[i][j] = 0;
                end
            end

            q <= 0;
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    grid[i][j] = next_grid[i][j];
                    q[i * 16 + j] = next_grid[i][j];
                end
            end
        end
    end
endmodule
