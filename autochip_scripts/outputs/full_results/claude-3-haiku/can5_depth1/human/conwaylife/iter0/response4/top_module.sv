module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

// Declare necessary variables
reg [255:0] next_state;
integer i, j;

// Update the game state at each clock cycle
always @(posedge clk) begin
    if (load) begin
        q <= data; // Load initial state
    end
    else begin
        q <= next_state; // Update to the next state
    end
end

// Implement the Game of Life rules
always @(*) begin
    for (i = 0; i < 256; i = i + 1) begin
        // Calculate the number of alive neighbors for each cell
        int alive_neighbors = 0;

        // Top-left neighbor
        if (i > 0 && i % 16 > 0) begin
            alive_neighbors += q[i - 17];
        end

        // Top neighbor
        if (i > 15) begin
            alive_neighbors += q[i - 16];
        end

        // Top-right neighbor
        if (i > 0 && i % 16 < 15) begin
            alive_neighbors += q[i - 15];
        end

        // Left neighbor
        if (i % 16 > 0) begin
            alive_neighbors += q[i - 1];
        end

        // Right neighbor
        if (i % 16 < 15) begin
            alive_neighbors += q[i + 1];
        end

        // Bottom-left neighbor
        if (i < 240 && i % 16 > 0) begin
            alive_neighbors += q[i + 15];
        end

        // Bottom neighbor
        if (i < 240) begin
            alive_neighbors += q[i + 16];
        end

        // Bottom-right neighbor
        if (i < 240 && i % 16 < 15) begin
            alive_neighbors += q[i + 17];
        end

        // Apply the Game of Life rules
        if (q[i]) begin // If the cell is currently alive
            if (alive_neighbors < 2 || alive_neighbors > 3) begin
                next_state[i] = 0; // Cell dies
            end
            else begin
                next_state[i] = 1; // Cell survives
            end
        end
        else begin // If the cell is currently dead
            if (alive_neighbors == 3) begin
                next_state[i] = 1; // Cell becomes alive
            end
            else begin
                next_state[i] = 0; // Cell remains dead
            end
        end
    end
end

endmodule
