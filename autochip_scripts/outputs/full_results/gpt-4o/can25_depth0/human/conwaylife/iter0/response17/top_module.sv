module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [15:0][15:0] grid;
    reg [15:0][15:0] next_grid;

    integer i, j;

    // Function to count the number of neighbours for a given cell
    function integer count_neighbours;
        input integer x;
        input integer y;
        integer count;
        begin
            count = 0;
            count = count + grid[(x+15)%16][(y+15)%16];
            count = count + grid[(x+15)%16][y];
            count = count + grid[(x+15)%16][(y+1)%16];
            count = count + grid[x][(y+15)%16];
            count = count + grid[x][(y+1)%16];
            count = count + grid[(x+1)%16][(y+15)%16];
            count = count + grid[(x+1)%16][y];
            count = count + grid[(x+1)%16][(y+1)%16];
            count_neighbours = count;
        end
    endfunction
    
    // Load initial state
    always @(posedge clk) begin
        if (load) begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    grid[i][j] = data[i*16 + j];
                end
            end
        end
    end

    // Calculate next state
    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                case (count_neighbours(i, j))
                    2: next_grid[i][j] = grid[i][j];
                    3: next_grid[i][j] = 1;
                    default: next_grid[i][j] = 0;
                endcase
            end
        end
    end

    // Update state
    always @(posedge clk) begin
        if (!load) begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    grid[i][j] = next_grid[i][j];
                    q[i*16 + j] = grid[i][j];
                end
            end
        end
    end

endmodule
