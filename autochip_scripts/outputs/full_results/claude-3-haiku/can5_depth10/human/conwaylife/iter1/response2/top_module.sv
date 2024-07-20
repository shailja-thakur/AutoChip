module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] q_next;

always @(*) begin
    q_next = q;
    for (int i = 0; i < 16; i++) begin
        for (int j = 0; j < 16; j++) begin
            int neighbors = 0;
            for (int di = -1; di <= 1; di++) begin
                for (int dj = -1; dj <= 1; dj++) begin
                    if (di != 0 || dj != 0) begin
                        int x = i + di;
                        int y = j + dj;
                        if (x < 0) x += 16;
                        else if (x >= 16) x -= 16;
                        if (y < 0) y += 16;
                        else if (y >= 16) y -= 16;
                        neighbors += q[x + y*16];
                    end
                end
            end
            if (q[i + j*16]) begin
                if (neighbors == 2 || neighbors == 3) begin
                    q_next[i + j*16] = 1;
                end else begin
                    q_next[i + j*16] = 0;
                end
            end else begin
                if (neighbors == 3) begin
                    q_next[i + j*16] = 1;
                end else begin
                    q_next[i + j*16] = 0;
                end
            end
        end
    end
end

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        q <= q_next;
    end
end

endmodule
