module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_state;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        q <= next_state;
    end
end

always @(*) begin
    next_state = 0;
    for (int i = 0; i < 256; i++) begin
        int alive_neighbors = 0;
        for (int dx = -1; dx <= 1; dx++) begin
            for (int dy = -1; dy <= 1; dx++) begin
                if (dx == 0 && dy == 0) continue;
                int nx = (i % 16) + dx;
                int ny = (i / 16) + dy;
                if (nx < 0) nx += 16;
                if (nx >= 16) nx -= 16;
                if (ny < 0) ny += 16;
                if (ny >= 16) ny -= 16;
                alive_neighbors += q[nx + 16 * ny];
            end
        end
        if (q[i] == 1) begin
            if (alive_neighbors == 2 || alive_neighbors == 3) begin
                next_state[i] = 1;
            end
            else begin
                next_state[i] = 0;
            end
        end
        else begin
            if (alive_neighbors == 3) begin
                next_state[i] = 1;
            end
            else begin
                next_state[i] = 0;
            end
        end
    end
end

endmodule
