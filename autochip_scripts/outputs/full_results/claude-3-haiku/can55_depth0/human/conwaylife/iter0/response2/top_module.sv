module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_state;

always @(*) begin
    // Compute the number of neighbors for each cell
    next_state = 0;
    for (int i = 0; i < 256; i++) begin
        int x = i % 16;
        int y = i / 16;
        int neighbors = 0;
        for (int dx = -1; dx <= 1; dx++) begin
            for (int dy = -1; dy <= 1; dy++) begin
                if (dx != 0 || dy != 0) begin
                    int nx = (x + dx + 16) % 16;
                    int ny = (y + dy + 16) % 16;
                    neighbors += q[ny * 16 + nx];
                end
            end
        end
        
        // Apply the game rules
        if (neighbors < 2 || neighbors > 3) begin
            next_state[i] = 0;
        end else if (neighbors == 2) begin
            next_state[i] = q[i];
        end else if (neighbors == 3) begin
            next_state[i] = 1;
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
