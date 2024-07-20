module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    // Internal variables to store and process the grid
    reg [15:0] grid [15:0];
    reg [15:0] next_grid [15:0];
    
    integer i, j;

    // Function to count the number of live neighbours of a cell
    function integer count_neighbours;
        input integer x;
        input integer y;
        integer x_offset, y_offset;
        integer x_neigh, y_neigh;
        integer count;
    begin
        count = 0;
        for (x_offset = -1; x_offset <= 1; x_offset = x_offset + 1) begin
            for (y_offset = -1; y_offset <= 1; y_offset = y_offset + 1) begin
                if (!(x_offset == 0 && y_offset == 0)) begin // Skip the cell itself
                    x_neigh = (x + x_offset) % 16;
                    y_neigh = (y + y_offset) % 16;
                    x_neigh = (x_neigh < 0) ? (x_neigh + 16) : x_neigh;
                    y_neigh = (y_neigh < 0) ? (y_neigh + 16) : y_neigh;
                    count = count + grid[x_neigh][y_neigh];
                end
            end
        end
        count_neighbours = count;
    end
    endfunction

    // Load data into the grid or update the grid based on the game's rules
    always @(posedge clk) begin
        if (load) begin
            for (i = 0; i < 16; i = i + 1) begin
                grid[i] = data[i*16 +: 16];
            end
        end
        else begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    case (count_neighbours(i, j))
                        2: next_grid[i][j] = grid[i][j]; // Cell state does not change
                        3: next_grid[i][j] = 1;           // Cell becomes 1
                        default: next_grid[i][j] = 0;     // Cell becomes 0
                    endcase
                end
            end
            for (i = 0; i < 16; i = i + 1) begin
                grid[i] = next_grid[i];
            end
        end

        // Flatten the 2D grid into the output vector q
        for (i = 0; i < 16; i = i + 1) begin
            q[i*16 +: 16] = grid[i];
        end
    end

endmodule
