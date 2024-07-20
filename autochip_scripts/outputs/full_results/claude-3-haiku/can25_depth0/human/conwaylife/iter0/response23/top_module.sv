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
    end else begin
        q <= next_q;
    end
end

always @(*) begin
    // Calculate the next state of the game
    for (int i = 0; i < 256; i++) begin
        int neighbors = 0;
        
        // Calculate the number of neighbors for the current cell
        for (int dx = -1; dx <= 1; dx++) begin
            for (int dy = -1; dy <= 1; dy++) begin
                if (dx == 0 && dy == 0) continue;
                int x = (i % 16) + dx;
                int y = (i / 16) + dy;
                
                // Wrap around the grid
                x = (x + 16) % 16;
                y = (y + 16) % 16;
                
                int neighbor_idx = y * 16 + x;
                neighbors += q[neighbor_idx];
            end
        end
        
        // Update the next state of the current cell
        if (q[i] == 1) begin
            if (neighbors == 2 || neighbors == 3) begin
                next_q[i] = 1;
            end else begin
                next_q[i] = 0;
            end
        end else begin
            if (neighbors == 3) begin
                next_q[i] = 1;
            end else begin
                next_q[i] = 0;
            end
        end
    end
end

endmodule
