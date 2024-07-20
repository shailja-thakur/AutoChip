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

    generate
        genvar i;
        for (i = 0; i < 256; i = i + 1) begin : ROWS
            always @* begin
                reg [3:0] neighbor_count;
                reg [7:0] row_index;
                reg [7:0] col_index;
                wire bit_nw, bit_n, bit_ne, bit_w, bit_e, bit_sw, bit_s, bit_se;

                // Calculate row and column indexes
                row_index = i / 16;
                col_index = i % 16;

                // Calculate neighbor cell indexes
                always @* begin
                    integer nw, n, ne, w, e, sw, s, se;

                    nw = ((row_index - 1 + 16) % 16) * 16 + (col_index - 1 + 16) % 16;
                    n = ((row_index - 1 + 16) % 16) * 16 + col_index;
                    ne = ((row_index - 1 + 16) % 16) * 16 + (col_index + 1) % 16;
                    w = row_index * 16 + (col_index - 1 + 16) % 16;
                    e = row_index * 16 + (col_index + 1) % 16;
                    sw = ((row_index + 1) % 16) * 16 + (col_index - 1 + 16) % 16;
                    s = ((row_index + 1) % 16) * 16 + col_index;
                    se = ((row_index + 1) % 16) * 16 + (col_index + 1) % 16;

                    bit_nw = q[nw];
                    bit_n = q[n];
                    bit_ne = q[ne];
                    bit_w = q[w];
                    bit_e = q[e];
                    bit_sw = q[sw];
                    bit_s = q[s];
                    bit_se = q[se];
                end

                // Determine the number of neighbors
                neighbor_count = bit_nw + bit_n + bit_ne + bit_w + bit_e + bit_sw + bit_s + bit_se;

                // Transition rules
                if (neighbor_count == 3)
                    next_q[i] = 1;
                else if (neighbor_count == 2)
                    next_q[i] = q[i];
                else
                    next_q[i] = 0;
            end
        end
    endgenerate

endmodule
