module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] q_next;
    integer i, j, idx, ni, nj, n_idx, neighbours;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Iterate over each cell in the 16x16 grid
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    idx = i*16 + j;
                    neighbours = 0;

                    // Check the 8 neighbours
                    for (ni = -1; ni <= 1; ni = ni + 1) begin
                        for (nj = -1; nj <= 1; nj = nj + 1) begin
                            if (ni != 0 || nj != 0) begin
                                n_idx = ((i + ni + 16) % 16) * 16 + ((j + nj + 16) % 16);
                                neighbours = neighbours + q[n_idx];
                            end
                        end
                    end

                    // Apply the rules of the game
                    if (neighbours < 2 || neighbours > 3) begin
                        q_next[idx] = 0;
                    end else if (neighbours == 3) begin
                        q_next[idx] = 1;
                    end else begin
                        q_next[idx] = q[idx];
                    end
                end
            end
            
            // Update the state
            q <= q_next;
        end
    end
endmodule
