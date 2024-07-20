module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    integer i, j;
    reg [15:0] grid [15:0]; // 16x16 grid
    reg [15:0] next_grid [15:0];

    // Function to calculate the number of live neighbors
    function integer live_neighbors;
        input integer x;
        input integer y;
        integer dx, dy;
        begin
            live_neighbors = 0;
            for (dx = -1; dx <= 1; dx = dx + 1) begin
                for (dy = -1; dy <= 1; dy = dy + 1) begin
                    if (dx != 0 || dy != 0) begin
                        live_neighbors = live_neighbors + grid[(x + dx + 16) % 16][(y + dy + 16) % 16];
                    end
                end
            end
        end
    endfunction

    // Initial load of data into the grid
    always @(posedge clk) begin
        if (load) begin
            for (i = 0; i < 16; i = i + 1) begin
                grid[i] = data[(i*16) +: 16]; // Load each row
            end
        end else begin
            // Calculate next state of the grid
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    case(live_neighbors(i, j))
                        2: next_grid[i][j] = grid[i][j]; // State does not change
                        3: next_grid[i][j] = 1; // Cell becomes alive
                        default: next_grid[i][j] = 0; // Cell becomes dead
                    endcase
                end
            end
            
            // Update the grid with next state
            for (i = 0; i < 16; i = i + 1) begin
                grid[i] = next_grid[i];
            end
        end
        
        // Update the output q
        for (i = 0; i < 16; i = i + 1) begin
            q[(i*16) +: 16] = grid[i];
        end
    end

endmodule
