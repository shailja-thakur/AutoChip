module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

    // Helper functions
    function int count_neighbors(input [255:0] state, input [7:0] index);
        // Calculate the number of living neighbors for the cell at the given index
        int neighbors = 0;
        int row = index / 16;
        int col = index % 16;

        // Iterate over the 8 neighboring cells
        for (int i = -1; i <= 1; i++) begin
            for (int j = -1; j <= 1; j++) begin
                if (i != 0 || j != 0) begin
                    int neighbor_row = (row + i + 16) % 16;
                    int neighbor_col = (col + j + 16) % 16;
                    int neighbor_index = neighbor_row * 16 + neighbor_col;
                    neighbors += (state[neighbor_index] == 1'b1) ? 1 : 0;
                end
            end
        end

        return neighbors;
    endfunction

    // Main logic
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (int i = 0; i < 256; i++) begin
                int num_neighbors = count_neighbors(q, i);
                if (q[i] == 1'b1) begin
                    // Cell is alive
                    q[i] <= (num_neighbors == 2 || num_neighbors == 3) ? 1'b1 : 1'b0;
                end else begin
                    // Cell is dead
                    q[i] <= (num_neighbors == 3) ? 1'b1 : 1'b0;
                end
            end
        end
    end

endmodule
