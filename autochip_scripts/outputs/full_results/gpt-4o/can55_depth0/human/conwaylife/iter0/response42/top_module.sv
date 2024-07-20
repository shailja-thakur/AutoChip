module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] next_q;

    always @(*) begin
        integer i, j, index, ni, nj;
        integer neighbors;
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                neighbors = 0;

                // Count the number of alive neighbors
                for (ni = -1; ni <= 1; ni = ni + 1) begin
                    for (nj = -1; nj <= 1; nj = nj + 1) begin
                        if (ni != 0 || nj != 0) begin
                            neighbors = neighbors + q[(((i + ni) + 16) % 16) * 16 + (((j + nj) + 16) % 16)];
                        end
                    end
                end

                index = i * 16 + j;
                if (q[index] == 1) begin
                    if (neighbors < 2 || neighbors > 3)
                        next_q[index] = 0;
                    else
                        next_q[index] = 1;
                end
                else begin
                    if (neighbors == 3)
                        next_q[index] = 1;
                    else
                        next_q[index] = 0;
                end
            end
        end
    end

    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= next_q;
    end
endmodule
