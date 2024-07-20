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
    next_q = q;
    for (int i = 0; i < 256; i++) begin
        int x = i % 16;
        int y = i / 16;
        int neighbors = 0;

        // Count the number of live neighbors
        for (int dx = -1; dx <= 1; dx++) begin
            for (int dy = -1; dy <= 1; dy++) begin
                if (dx == 0 && dy == 0) continue;
                int nx = (x + dx + 16) % 16;
                int ny = (y + dy + 16) % 16;
                neighbors += q[(ny * 16) + nx];
            end
        end

        // Update the cell state
        if (q[i] == 1'b1) begin
            if (neighbors < 2 || neighbors > 3) begin
                next_q[i] = 1'b0;
            end else begin
                next_q[i] = 1'b1;
            end
        end else begin
            if (neighbors == 3) begin
                next_q[i] = 1'b1;
            end else begin
                next_q[i] = 1'b0;
            end
        end
    end
end

endmodule
