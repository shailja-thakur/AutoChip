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
    next_q = q;
    for (int i = 0; i < 256; i++) begin
        int x = i % 16;
        int y = i / 16;
        int alive_neighbors = 0;

        // Wrap around grid
        int xm1 = (x == 0) ? 15 : x - 1;
        int xp1 = (x == 15) ? 0 : x + 1;
        int ym1 = (y == 0) ? 15 : y - 1;
        int yp1 = (y == 15) ? 0 : y + 1;

        // Count alive neighbors
        alive_neighbors += q[xm1 + ym1 * 16];
        alive_neighbors += q[x + ym1 * 16];
        alive_neighbors += q[xp1 + ym1 * 16];
        alive_neighbors += q[xm1 + y * 16];
        alive_neighbors += q[xp1 + y * 16];
        alive_neighbors += q[xm1 + yp1 * 16];
        alive_neighbors += q[x + yp1 * 16];
        alive_neighbors += q[xp1 + yp1 * 16];

        // Update next state
        if (q[i]) begin
            if (alive_neighbors == 2 || alive_neighbors == 3) begin
                next_q[i] = 1;
            end
            else begin
                next_q[i] = 0;
            end
        end
        else begin
            if (alive_neighbors == 3) begin
                next_q[i] = 1;
            end
            else begin
                next_q[i] = 0;
            end
        end
    end
end

endmodule
