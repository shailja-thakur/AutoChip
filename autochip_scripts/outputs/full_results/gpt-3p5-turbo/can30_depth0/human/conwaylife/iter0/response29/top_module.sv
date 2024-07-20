module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] next_q;

    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= next_q;
    end

    integer i, j, n;

    always @* begin
        for (i = 0; i < 256; i = i + 16) begin
            for (j = 0; j < 16; j = j + 1) begin
                n = 0;
                if (q[(i + 15) % 256 + j]) n = n + 1;
                if (q[(i + 15) % 256 + (j + 1) % 16]) n = n + 1;
                if (q[(i + 15) % 256 + (j + 15) % 16]) n = n + 1;
                if (q[(i + 15) % 256 + (j + 256 - 16) % 16]) n = n + 1;
                if (q[(i + 1) % 256 + j]) n = n + 1;
                if (q[(i + 1) % 256 + (j + 1) % 16]) n = n + 1;
                if (q[(i + 1) % 256 + (j + 15) % 16]) n = n + 1;
                if (q[(i + 1) % 256 + (j + 256 - 16) % 16]) n = n + 1;
                if (q[(i + 256 - 16) % 256 + j]) n = n + 1;
                if (q[(i + 256 - 16) % 256 + (j + 1) % 16]) n = n + 1;
                if (q[(i + 256 - 16) % 256 + (j + 15) % 16]) n = n + 1;
                if (q[(i + 256 - 16) % 256 + (j + 256 - 16) % 16]) n = n + 1;
                if (q[(i + 256 + 16) % 256 + j]) n = n + 1;
                if (q[(i + 256 + 16) % 256 + (j + 1) % 16]) n = n + 1;
                if (q[(i + 256 + 16) % 256 + (j + 15) % 16]) n = n + 1;
                if (q[(i + 256 + 16) % 256 + (j + 256 - 16) % 16]) n = n + 1;

                if (q[i + j]) begin
                    if (n < 2 || n > 3)
                        next_q[i + j] = 0;
                    else
                        next_q[i + j] = 1;
                end else begin
                    if (n == 3)
                        next_q[i + j] = 1;
                    else
                        next_q[i + j] = 0;
                end
            end
        end
    end

endmodule
