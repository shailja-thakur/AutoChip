module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_q;

// Helper functions to calculate the number of neighbors for a given cell
function integer get_neighbor_count(integer row, integer col);
    integer count = 0;
    // Top row
    if (row > 0)
        count += q[(row-1)*16 + col];
    else
        count += q[((row-1+16)*16) + col];
    // Bottom row
    if (row < 15)
        count += q[(row+1)*16 + col];
    else
        count += q[(row+1-16)*16 + col];
    // Left column
    if (col > 0)
        count += q[row*16 + col-1];
    else
        count += q[row*16 + col-1+16];
    // Right column
    if (col < 15)
        count += q[row*16 + col+1];
    else
        count += q[row*16 + col+1-16];
    // Top left
    if (row > 0 && col > 0)
        count += q[(row-1)*16 + col-1];
    else if (row > 0)
        count += q[(row-1)*16 + col-1+16];
    else if (col > 0)
        count += q[(row-1+16)*16 + col-1];
    else
        count += q[(row-1+16)*16 + col-1+16];
    // Top right
    if (row > 0 && col < 15)
        count += q[(row-1)*16 + col+1];
    else if (row > 0)
        count += q[(row-1)*16 + col+1-16];
    else if (col < 15)
        count += q[(row-1+16)*16 + col+1];
    else
        count += q[(row-1+16)*16 + col+1-16];
    // Bottom left
    if (row < 15 && col > 0)
        count += q[(row+1)*16 + col-1];
    else if (row < 15)
        count += q[(row+1)*16 + col-1+16];
    else if (col > 0)
        count += q[(row+1-16)*16 + col-1];
    else
        count += q[(row+1-16)*16 + col-1+16];
    // Bottom right
    if (row < 15 && col < 15)
        count += q[(row+1)*16 + col+1];
    else if (row < 15)
        count += q[(row+1)*16 + col+1-16];
    else if (col < 15)
        count += q[(row+1-16)*16 + col+1];
    else
        count += q[(row+1-16)*16 + col+1-16];
    return count;
endfunction

// Game logic
always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        for (integer i = 0; i < 16; i++) begin
            for (integer j = 0; j < 16; j++) begin
                integer neighbors = get_neighbor_count(i, j);
                if (q[i*16 + j] == 1 && (neighbors < 2 || neighbors > 3)) begin
                    next_q[i*16 + j] = 0;
                end else if (q[i*16 + j] == 0 && neighbors == 3) begin
                    next_q[i*16 + j] = 1;
                end else begin
                    next_q[i*16 + j] = q[i*16 + j];
                end
            end
        end
        q <= next_q;
    end
end

endmodule
