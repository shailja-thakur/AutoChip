module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_state;

always @(*) begin
    // Compute the next state of the game based on the current state
    for (int i = 0; i < 256; i++) begin
        int neighbors = 0;
        
        // Compute the number of alive neighbors for each cell
        // Taking into account the toroidal wrapping
        int row = i / 16;
        int col = i % 16;
        for (int dr = -1; dr <= 1; dr++) begin
            for (int dc = -1; dc <= 1; dc++) begin
                if (dr == 0 && dc == 0)
                    continue;
                int nrow = (row + dr + 16) % 16;
                int ncol = (col + dc + 16) % 16;
                int n_idx = nrow * 16 + ncol;
                neighbors += q[n_idx];
            end
        end
        
        // Apply the game of life rules to determine the next state
        if (q[i]) begin // Current cell is alive
            if (neighbors < 2 || neighbors > 3)
                next_state[i] = 0; // Cell dies
            else
                next_state[i] = 1; // Cell lives
        end else begin // Current cell is dead
            if (neighbors == 3)
                next_state[i] = 1; // Cell becomes alive
            else
                next_state[i] = 0; // Cell remains dead
        end
    end
end

always @(posedge clk) begin
    if (load)
        q <= data;
    else
        q <= next_state;
end

endmodule
