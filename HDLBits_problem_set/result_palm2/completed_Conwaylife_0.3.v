module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 

    reg [255:0] q;
    reg [255:0] next_q;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            next_q <= q;
            for (int i = 0; i < 16; i++) begin
                for (int j = 0; j < 16; j++) begin
                    next_q[i * 16 + j] <= (q[i * 16 + j] == 1) ? (count_neighbors(i, j) == 2 || count_neighbors(i, j) == 3) : 0;
                end
            end
            q <= next_q;
        end
    end

    function int count_neighbors(int i, int j);
        int count = 0;
        for (int di = -1; di <= 1; di++) begin
            for (int dj = -1; dj <= 1; dj++) begin
                if (i + di >= 0 && i + di < 16 && j + dj >= 0 && j + dj < 16) begin
                    if (q[i + di * 16 + j + dj] == 1) begin
                        count++;
                    end
                end
            end
        end
        return count;
    end

endmodule