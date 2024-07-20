module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [3:0] i, j; // Loop indices
    reg [8:0] indices [0:255]; // For neighborhood indices
    reg [3:0] row [0:8], col [0:8]; // For neighbor row and col

    // Initialize neighborhood index displacements
    initial begin
        indices[0] = 244; indices[1] = 245; indices[2] = 246; indices[3] = 252; indices[4] = 254; indices[5] = 256;
        indices[6] = 260; indices[7] = 261; indices[8] = 262;
    end

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Use a temporary array to store next state
            reg [255:0] new_q;
            
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    // Calculate number of alive neighbors
                    integer count;
                    count = 0;
                    row[0] = (i == 0) ? 15 : i - 1;
                    row[1] = i;
                    row[2] = (i == 15) ? 0 : i + 1;
                    col[0] = (j == 0) ? 15 : j - 1;
                    col[1] = j;
                    col[2] = (j == 15) ? 0 : j + 1;

                    // Count alive neighbours
                    for (integer m = 0; m < 3; m = m + 1) begin
                        for (integer n = 0; n < 3; n = n + 1) begin
                            if (!(m == 1 && n == 1)) begin
                                if (q[row[m] * 16 + col[n]] == 1) count = count + 1;
                            end
                        end
                    end

                    // Update cell state
                    if (count <= 1 || count > 3)
                        new_q[i*16 + j] = 0;
                    else if (count == 3)
                        new_q[i*16 + j] = 1;
                    else
                        new_q[i*16 + j] = q[i*16 + j];

                end
            end
            q <= new_q;
        end
    end
endmodule
