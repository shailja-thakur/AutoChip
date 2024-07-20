module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_q;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        q <= next_q;
    end
end

always @(*) begin
    // Initialize next_q with the current state q
    next_q = q;

    // Iterate through each cell in the 16x16 grid
    for (int i = 0; i < 16; i++) begin
        for (int j = 0; j < 16; j++) {
            int index = i * 16 + j;
            int alive_neighbors = 0;

            // Count the number of alive neighbors for the current cell
            if (q[index - 1] & j != 0) alive_neighbors++; // Left neighbor
            if (q[index + 1] & j != 15) alive_neighbors++; // Right neighbor
            if (q[index - 16] & i != 0) alive_neighbors++; // Top neighbor
            if (q[index + 16] & i != 15) alive_neighbors++; // Bottom neighbor
            if (q[index - 15] & (i != 0) & (j != 15)) alive_neighbors++; // Top-right neighbor
            if (q[index - 17] & (i != 0) & (j != 0)) alive_neighbors++; // Top-left neighbor
            if (q[index + 15] & (i != 15) & (j != 15)) alive_neighbors++; // Bottom-right neighbor
            if (q[index + 17] & (i != 15) & (j != 0)) alive_neighbors++; // Bottom-left neighbor

            // Update the next state of the current cell based on the rules
            if (q[index] & (alive_neighbors == 2 | alive_neighbors == 3)) begin
                // Cell with 2 or 3 neighbors stays alive
                next_q[index] = 1;
            end
            else if (~q[index] & alive_neighbors == 3) begin
                // Dead cell with 3 neighbors becomes alive
                next_q[index] = 1;
            end
            else begin
                // All other cases, cell becomes dead
                next_q[index] = 0;
            end
        end
    end
end

endmodule
