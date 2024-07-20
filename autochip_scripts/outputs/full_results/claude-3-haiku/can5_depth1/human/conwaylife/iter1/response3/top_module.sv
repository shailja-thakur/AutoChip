module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_state;

always @(posedge clk) begin
    if (load)
        q <= data;
    else
        q <= next_state;
end

always @(*) begin
    next_state = q;
    for (int i = 0; i < 256; i++) begin
        int x = i % 16;
        int y = i / 16;
        int neighbors = 0;

        // Calculate number of neighbors
        for (int dx = -1; dx <= 1; dx++) begin
            for (int dy = -1; dy <= 1; dy++) begin
                if (dx != 0 || dy != 0) begin
                    int nx = (x + dx + 16) % 16;
                    int ny = (y + dy + 16) % 16;
                    int neighbor_index = nx + ny * 16;
                    neighbors += q[neighbor_index];
                end
            end
        end

        // Update cell state
        if (q[i] == 1) begin
            if (neighbors < 2 || neighbors > 3)
                next_state[i] = 0;
            else
                next_state[i] = 1;
        end else begin
            if (neighbors == 3)
                next_state[i] = 1;
            else
                next_state[i] = 0;
        end
    end
end

endmodule
module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_state;
reg [3:0] x, y, nx, ny;
reg [7:0] neighbor_index;
reg [3:0] neighbors;

always @(posedge clk) begin
    if (load)
        q <= data;
    else
        q <= next_state;
end

always @(*) begin
    next_state = q;
    for (x = 0; x < 16; x++) begin
        for (y = 0; y < 16; y++) begin
            neighbor_index = x + y * 16;
            neighbors = 0;

            // Calculate number of neighbors
            for (dx = -1; dx <= 1; dx++) begin
                for (dy = -1; dy <= 1; dy++) begin
                    if (dx != 0 || dy != 0) begin
                        nx = (x + dx + 16) % 16;
                        ny = (y + dy + 16) % 16;
                        neighbor_index = nx + ny * 16;
                        neighbors += q[neighbor_index];
                    end
                end
            end

            // Update cell state
            if (q[neighbor_index] == 1) begin
                if (neighbors < 2 || neighbors > 3)
                    next_state[neighbor_index] = 0;
                else
                    next_state[neighbor_index] = 1;
            end else begin
                if (neighbors == 3)
                    next_state[neighbor_index] = 1;
                else
                    next_state[neighbor_index] = 0;
            end
        end
    end
end

endmodule
