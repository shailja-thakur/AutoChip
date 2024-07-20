module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_q;

always @(*) begin
    next_q = q;
    for (int i = 0; i < 256; i++) begin
        int x = i % 16;
        int y = i / 16;
        int neighbours = 0;

        // Compute the number of live neighbors for cell (x, y)
        for (int dx = -1; dx <= 1; dx++) begin
            for (int dy = -1; dy <= 1; dy++) begin
                if (dx != 0 || dy != 0) begin
                    int nx = (x + dx + 16) % 16;
                    int ny = (y + dy + 16) % 16;
                    int idx = nx + ny * 16;
                    if (q[idx]) neighbours++;
                end
            end
        end

        // Update the state of cell (x, y) based on the rules
        if (q[i]) begin
            if (neighbours < 2 || neighbours > 3) next_q[i] = 0;
            else next_q[i] = 1;
        end else begin
            if (neighbours == 3) next_q[i] = 1;
            else next_q[i] = 0;
        end
    end
end

always @(posedge clk) begin
    if (load) q <= data;
    else q <= next_q;
end

endmodule
