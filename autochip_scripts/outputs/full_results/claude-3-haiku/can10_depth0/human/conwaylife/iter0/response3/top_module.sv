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
    for (int i = 0; i < 16; i++) begin
        for (int j = 0; j < 16; j++) begin
            int neighbors = 0;
            int idx = i * 16 + j;
            for (int di = -1; di <= 1; di++) begin
                for (int dj = -1; dj <= 1; dj++) begin
                    if (di != 0 || dj != 0) begin
                        int ni = (i + di + 16) % 16;
                        int nj = (j + dj + 16) % 16;
                        int nidx = ni * 16 + nj;
                        neighbors += q[nidx];
                    end
                end
            end
            if (q[idx] == 1) begin
                if (neighbors == 2 || neighbors == 3) begin
                    next_state[idx] = 1;
                end
                else begin
                    next_state[idx] = 0;
                end
            end
            else begin
                if (neighbors == 3) begin
                    next_state[idx] = 1;
                end
                else begin
                    next_state[idx] = 0;
                end
            end
        end
    end
end

endmodule
