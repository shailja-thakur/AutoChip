module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

    integer i, j, idx, ni, nj;
    integer alive_neighbours;
    reg [15:0] curr_row, next_row;
    reg [3:0] row_lut[18:0];
    reg [255:0] next_q;

    initial begin
        q = 256'b0;
    end

    // Pre-compute the look-up table for number of alive neighbours
    initial begin
        row_lut[0] = 4'd0;
        row_lut[1] = 4'd1;
        row_lut[2] = 4'd1;
        row_lut[3] = 4'd2;
        row_lut[4] = 4'd1;
        row_lut[5] = 4'd2;
        row_lut[6] = 4'd2;
        row_lut[7] = 4'd3;
        row_lut[8] = 4'd1;
        row_lut[9] = 4'd2;
        row_lut[10] = 4'd2;
        row_lut[11] = 4'd3;
        row_lut[12] = 4'd2;
        row_lut[13] = 4'd3;
        row_lut[14] = 4'd3;
        row_lut[15] = 4'd4;
        row_lut[16] = 4'd4;
        row_lut[17] = 4'd4;
        row_lut[18] = 4'd4;
    end

    // Update the state on the positive edge of the clock
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    // Iterate over the 3x3 neighbourhood
                    alive_neighbours = 0;
                    for (ni = -1; ni <= 1; ni = ni + 1) begin
                        for (nj = -1; nj <= 1; nj = nj + 1) begin
                            if (!(ni == 0 && nj == 0)) begin
                                // Compute wrapped index for neighbours
                                idx = ((i + ni + 16) % 16) * 16 + ((j + nj + 16) % 16);
                                alive_neighbours = alive_neighbours + q[idx];
                            end
                        end
                    end

                    idx = i * 16 + j;
                    next_row[j] = q[idx];

                    // Apply the Game of Life rules
                    if (alive_neighbours < 2 || alive_neighbours > 3) begin
                        next_row[j] = 0;
                    end else if (alive_neighbours == 3) begin
                        next_row[j] = 1;
                    end
                end
                next_q[i*16 +: 16] = next_row;
            end
            q <= next_q;
        end
    end

endmodule
