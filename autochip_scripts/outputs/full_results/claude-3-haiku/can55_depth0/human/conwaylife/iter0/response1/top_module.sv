module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_state;

always @(*) begin
    next_state = q;
    for (int i = 0; i < 256; i++) begin
        int row = i / 16;
        int col = i % 16;
        int neighbors = 0;

        // Calculate the number of neighbors for the current cell
        for (int dx = -1; dx <= 1; dx++) begin
            for (int dy = -1; dy <= 1; dy++) begin
                if (dx == 0 && dy == 0) continue;
                int x = (col + dx + 16) % 16;
                int y = (row + dy + 16) % 16;
                neighbors += q[y * 16 + x];
            end
        end

        // Update the next state based on the number of neighbors
        if (q[i] == 1'b1) begin
            if (neighbors < 2 || neighbors > 3) begin
                next_state[i] = 1'b0;
            end else begin
                next_state[i] = 1'b1;
            end
        end else begin
            if (neighbors == 3) begin
                next_state[i] = 1'b1;
            end
        end
    end
end

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        q <= next_state;
    end
end

endmodule
