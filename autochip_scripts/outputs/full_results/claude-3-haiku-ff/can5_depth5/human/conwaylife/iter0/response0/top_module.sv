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
        int neighbors = 0;
        int row = i / 16;
        int col = i % 16;
        
        // Compute the number of neighbors for each cell
        for (int dx = -1; dx <= 1; dx++) begin
            for (int dy = -1; dy <= 1; dy++) begin
                if (dx != 0 || dy != 0) begin
                    int x = (col + dx + 16) % 16;
                    int y = (row + dy + 16) % 16;
                    neighbors += q[y*16 + x];
                end
            end
        end
        
        // Update the cell state based on the number of neighbors
        if (q[i] == 1) begin
            if (neighbors < 2 || neighbors > 3) begin
                next_q[i] = 0;
            end
        end
        else begin
            if (neighbors == 3) begin
                next_q[i] = 1;
            end
        end
    end
end

endmodule
