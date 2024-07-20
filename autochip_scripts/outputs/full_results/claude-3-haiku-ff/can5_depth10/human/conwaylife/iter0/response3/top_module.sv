module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_q;

always @(*) begin
    // Compute the next state of the game
    for (int y = 0; y < 16; y++) begin
        for (int x = 0; x < 16; x++) begin
            int neighbors = 0;
            // Count the neighbors of the current cell
            for (int dy = -1; dy <= 1; dy++) begin
                for (int dx = -1; dx <= 1; dx++) begin
                    if (dx != 0 || dy != 0) begin
                        int nx = (x + dx + 16) % 16;
                        int ny = (y + dy + 16) % 16;
                        neighbors += q[nx + ny * 16];
                    end
                end
            end
            // Update the next state based on the number of neighbors
            if (q[x + y * 16]) begin
                next_q[x + y * 16] = (neighbors == 2 || neighbors == 3);
            end else begin
                next_q[x + y * 16] = (neighbors == 3);
            end
        end
    end
end

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        q <= next_q;
    end
end

endmodule
