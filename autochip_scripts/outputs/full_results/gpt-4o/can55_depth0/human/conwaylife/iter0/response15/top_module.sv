module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

    reg [255:0] next_q;

    always @(*) begin
        integer i, j;
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                // Calculate the indices of the 8 neighbors (with wrap-around)
                integer ul = ((i - 1 + 16) % 16) * 16 + ((j - 1 + 16) % 16);
                integer uc = ((i - 1 + 16) % 16) * 16 + j;
                integer ur = ((i - 1 + 16) % 16) * 16 + ((j + 1) % 16);
                integer cl = i * 16 + ((j - 1 + 16) % 16);
                integer cr = i * 16 + ((j + 1) % 16);
                integer dl = ((i + 1) % 16) * 16 + ((j - 1 + 16) % 16);
                integer dc = ((i + 1) % 16) * 16 + j;
                integer dr = ((i + 1) % 16) * 16 + ((j + 1) % 16);

                // Count the number of alive neighbors
                integer alive_neighbors = q[ul] + q[uc] + q[ur] + q[cl] + q[cr] + q[dl] + q[dc] + q[dr];
                integer current_index = i * 16 + j;

                // Apply the rule to determine the next state
                if (alive_neighbors < 2 || alive_neighbors > 3)
                    next_q[current_index] = 0;
                else if (alive_neighbors == 3)
                    next_q[current_index] = 1;
                else
                    next_q[current_index] = q[current_index]; // alive_neighbors == 2
            end
        end
    end

    // Sequential block to load data or update q
    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= next_q;
    end

endmodule
