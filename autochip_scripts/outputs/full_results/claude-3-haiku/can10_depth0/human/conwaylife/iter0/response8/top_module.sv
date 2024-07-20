module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

// Helper functions to get the number of neighbors for a given cell
function int get_num_neighbors(input [255:0] state, input [$clog2(256)-1:0] row, input [$clog2(256)-1:0] col);
    int num_neighbors = 0;
    // Check the 8 surrounding cells
    for (int i = -1; i <= 1; i++) begin
        for (int j = -1; j <= 1; j++) begin
            if (i == 0 && j == 0) continue; // Skip the cell itself
            int neighbor_row = (row + i + 16) % 16;
            int neighbor_col = (col + j + 16) % 16;
            if (state[neighbor_row * 16 + neighbor_col]) num_neighbors++;
        end
    end
    return num_neighbors;
endfunction

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        for (int i = 0; i < 256; i++) begin
            int row = i / 16;
            int col = i % 16;
            int num_neighbors = get_num_neighbors(q, row, col);
            if (q[i]) begin
                if (num_neighbors < 2 || num_neighbors > 3) begin
                    q[i] <= 1'b0; // Cell dies
                end
            end
            else begin
                if (num_neighbors == 3) begin
                    q[i] <= 1'b1; // Cell becomes alive
                end
            end
        end
    end
end

endmodule
