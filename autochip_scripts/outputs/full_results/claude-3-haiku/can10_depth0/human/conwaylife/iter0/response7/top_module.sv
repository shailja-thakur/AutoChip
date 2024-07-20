module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_state;

integer i;

always @(*) begin
    // Compute the next state of the game based on the current state
    for (i = 0; i < 256; i = i + 1) begin
        // Apply the rules of the game of life
        if (q[i] == 1'b1) begin
            // Cell is alive
            if (count_neighbors(i, q) < 2 || count_neighbors(i, q) > 3) begin
                // Cell dies
                next_state[i] = 1'b0;
            end else begin
                // Cell survives
                next_state[i] = 1'b1;
            end
        end else begin
            // Cell is dead
            if (count_neighbors(i, q) == 3) begin
                // Cell is born
                next_state[i] = 1'b1;
            end else begin
                // Cell remains dead
                next_state[i] = 1'b0;
            end
        end
    end
end

always @(posedge clk) begin
    if (load) begin
        // Load the initial state
        q <= data;
    end else begin
        // Update the game state
        q <= next_state;
    end
end

function integer count_neighbors(
    input integer index,
    input [255:0] state
);
    // Count the number of neighbors for the cell at the given index
    integer x, y, dx, dy, neighbor_count;
    x = index % 16;
    y = index / 16;
    neighbor_count = 0;
    for (dx = -1; dx <= 1; dx = dx + 1) begin
        for (dy = -1; dy <= 1; dy = dy + 1) begin
            if (dx != 0 || dy != 0) begin
                if (x + dx < 0) begin
                    // Wrap around left edge
                    if (state[((y + dy) % 16) * 16 + 15] == 1'b1) begin
                        neighbor_count = neighbor_count + 1;
                    end
                end else if (x + dx >= 16) begin
                    // Wrap around right edge
                    if (state[((y + dy) % 16) * 16 + 0] == 1'b1) begin
                        neighbor_count = neighbor_count + 1;
                    end
                end else if (y + dy < 0) begin
                    // Wrap around top edge
                    if (state[(15 * 16) + (x + dx)] == 1'b1) begin
                        neighbor_count = neighbor_count + 1;
                    end
                end else if (y + dy >= 16) begin
                    // Wrap around bottom edge
                    if (state[0 + (x + dx)] == 1'b1) begin
                        neighbor_count = neighbor_count + 1;
                    end
                end else begin
                    // Normal cell
                    if (state[((y + dy) * 16) + (x + dx)] == 1'b1) begin
                        neighbor_count = neighbor_count + 1;
                    end
                end
            end
        end
    end
    return neighbor_count;
endfunction

endmodule
