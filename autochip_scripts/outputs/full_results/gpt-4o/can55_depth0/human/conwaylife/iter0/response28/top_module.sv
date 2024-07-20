module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    wire [15:0][15:0] grid;
    wire [15:0][15:0] new_grid;
    reg [15:0] neighbors;
    integer i, j;

    // Convert the 256-bit vector into a 16x16 grid
    genvar r, c;
    generate
        for (r = 0; r < 16; r = r + 1) begin : row_gen
            for (c = 0; c < 16; c = c + 1) begin : col_gen
                assign grid[r][c] = q[r*16 + c];
            end
        end
    endgenerate

    // Count the number of neighbors for each cell
    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                neighbors = 
                    grid[(i+15) % 16][(j+15) % 16] +
                    grid[(i+15) % 16][j] +
                    grid[(i+15) % 16][(j+1) % 16] +
                    grid[i][(j+15) % 16] +
                    grid[i][(j+1) % 16] +
                    grid[(i+1) % 16][(j+15) % 16] +
                    grid[(i+1) % 16][j] +
                    grid[(i+1) % 16][(j+1) % 16];
                
                // Update the new grid based on the rules
                case (neighbors)
                    2: new_grid[i][j] = grid[i][j]; // Cell state does not change
                    3: new_grid[i][j] = 1; // Cell becomes alive
                    default: new_grid[i][j] = 0; // Cell becomes dead
                endcase
            end
        end
    end

    // Load initial data or update the state on each clock cycle
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    q[i*16 + j] <= new_grid[i][j];
                end
            end
        end
    end
endmodule
