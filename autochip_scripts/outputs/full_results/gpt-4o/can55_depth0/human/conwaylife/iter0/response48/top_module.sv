module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] next_q;
    integer i, j, index, ni, nj;

    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                integer alive_neighbours = 0;

                // Count alive neighbours
                for (ni = -1; ni <= 1; ni = ni + 1) begin
                    for (nj = -1; nj <= 1; nj = nj + 1) begin
                        if (ni != 0 || nj != 0) begin
                            integer row = (i + ni + 16) % 16;
                            integer col = (j + nj + 16) % 16;
                            index = row * 16 + col;
                            alive_neighbours = alive_neighbours + q[index];
                        end
                    end
                end

                // Determine next state for cell (i, j)
                index = i * 16 + j;
                case (alive_neighbours)
                    2: next_q[index] = q[index]; // Stay the same
                    3: next_q[index] = 1;       // Becomes alive
                    default: next_q[index] = 0; // Becomes dead
                endcase
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
