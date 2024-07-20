module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [15:0] grid [15:0]; // 2D representation of the 16x16 grid

    integer i, j;

    // Convert 1D data into 2D grid format
    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                grid[i][j] = data[i * 16 + j];
            end
        end
    end

    function integer count_neighbours;
        input integer x, y;
        integer xx, yy, sum;
        begin
            sum = 0;
            for (xx = -1; xx <= 1; xx = xx + 1) begin
                for (yy = -1; yy <= 1; yy = yy + 1) begin
                    if (!(xx == 0 && yy == 0)) begin
                        // Wrapping around in a toroidal manner
                        sum = sum + grid[(x + xx + 16) % 16][(y + yy + 16) % 16];
                    end
                end
            end
            count_neighbours = sum;
        end
    endfunction

    always @(posedge clk) begin
        if (load) begin
            q <= data; // Load initial state
        end else begin
            reg [15:0] next_grid [15:0]; // New grid state
            integer x, y;
            for (x = 0; x < 16; x = x + 1) begin
                for (y = 0; y < 16; y = y + 1) begin
                    case (count_neighbours(x, y))
                        2: next_grid[x][y] = grid[x][y]; // State doesn't change
                        3: next_grid[x][y] = 1; // Cell becomes alive
                        default: next_grid[x][y] = 0; // Cell dies
                    endcase
                end
            end

            // Flatten the 2D grid back into 1D vector
            for (x = 0; x < 16; x = x + 1) begin
                for (y = 0; y < 16; y = y + 1) begin
                    q[x * 16 + y] <= next_grid[x][y];
                end
            end
        end
    end
endmodule
