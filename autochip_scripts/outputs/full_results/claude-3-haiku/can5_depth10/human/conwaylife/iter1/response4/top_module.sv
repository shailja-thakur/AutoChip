module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] q_next;

always @(*) begin
    q_next = q;
    for (int i = 0; i < 256; i++) begin
        int x = i % 16;
        int y = i / 16;
        int alive_neighbors = 0;

        // Wrap-around the grid
        int left = (x == 0) ? 15 : x - 1;
        int right = (x == 15) ? 0 : x + 1;
        int up = (y == 0) ? 15 : y - 1;
        int down = (y == 15) ? 0 : y + 1;

        alive_neighbors += q[left + 16 * up];
        alive_neighbors += q[left + 16 * y];
        alive_neighbors += q[left + 16 * down];
        alive_neighbors += q[x + 16 * up];
        alive_neighbors += q[x + 16 * down];
        alive_neighbors += q[right + 16 * up];
        alive_neighbors += q[right + 16 * y];
        alive_neighbors += q[right + 16 * down];

        // Update the cell state
        if (q[i]) begin
            if (alive_neighbors < 2 || alive_neighbors > 3)
                q_next[i] = 0;
        end else begin
            if (alive_neighbors == 3)
                q_next[i] = 1;
        end
    end
end

always @(posedge clk) begin
    if (load)
        q <= data;
    else
        q <= q_next;
end

endmodule
