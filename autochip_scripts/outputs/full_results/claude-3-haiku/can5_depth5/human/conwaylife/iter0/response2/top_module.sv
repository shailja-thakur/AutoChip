module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

// Helper function to get the number of live neighbors for a cell
function integer get_neighbors(input [255:0] state, input integer row, input integer col);
    integer count = 0;
    integer r, c;
    
    // Iterate over the 8 neighboring cells
    for (r = row - 1; r <= row + 1; r = r + 1) begin
        for (c = col - 1; c <= col + 1; c = c + 1) begin
            // Wrap around the toroid
            integer rr = (r < 0) ? r + 16 : ((r > 15) ? r - 16 : r);
            integer cc = (c < 0) ? c + 16 : ((c > 15) ? c - 16 : c);
            
            // Skip the cell itself
            if (rr == row && cc == col) begin
                continue;
            end
            
            // Count the live neighbors
            if (state[rr * 16 + cc]) begin
                count = count + 1;
            end
        end
    end
    
    return count;
endfunction

// Game of Life logic
always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        for (integer i = 0; i < 16; i = i + 1) begin
            for (integer j = 0; j < 16; j = j + 1) begin
                integer neighbors = get_neighbors(q, i, j);
                if (q[i * 16 + j]) begin
                    // Living cell
                    q[i * 16 + j] <= (neighbors == 2 || neighbors == 3);
                end else begin
                    // Dead cell
                    q[i * 16 + j] <= (neighbors == 3);
                end
            end
        end
    end
end

endmodule
