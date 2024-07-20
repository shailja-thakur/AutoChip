module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] next_q;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (int i = 0; i < 256; i = i + 1) begin
                int row = i / 16;
                int col = i % 16;
                int neighbors = 0;

                if (q[((row + 15) % 16) * 16 + ((col + 15) % 16)]) neighbors = neighbors + 1;
                if (q[((row + 15) % 16) * 16 + col]) neighbors = neighbors + 1;
                if (q[((row + 15) % 16) * 16 + ((col + 1) % 16)]) neighbors = neighbors + 1;
                if (q[row * 16 + ((col + 15) % 16)]) neighbors = neighbors + 1;
                if (q[row * 16 + ((col + 1) % 16)]) neighbors = neighbors + 1;
                if (q[((row + 1) % 16) * 16 + ((col + 15) % 16)]) neighbors = neighbors + 1;
                if (q[((row + 1) % 16) * 16 + col]) neighbors = neighbors + 1;
                if (q[((row + 1) % 16) * 16 + ((col + 1) % 16)]) neighbors = neighbors + 1;

                if (neighbors <= 1) begin
                    next_q[i] <= 0;
                end else if (neighbors == 3) begin
                    next_q[i] <= 1;
                end else if (neighbors >= 4) begin
                    next_q[i] <= 0;
                end else begin
                    next_q[i] <= q[i];
                end
            end

            q <= next_q;
        end
    end

endmodule
