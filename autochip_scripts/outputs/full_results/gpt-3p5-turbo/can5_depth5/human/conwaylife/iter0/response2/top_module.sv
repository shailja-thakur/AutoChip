module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] temp_q;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            temp_q <= q;
            for (int i = 0; i < 256; i = i + 16) begin
                for (int j = 0; j < 16; j = j + 1) begin
                    // Get the number of neighbors for cell (i + j)
                    int num_neighbors = 0;
                    
                    // Check top left neighbor
                    if (temp_q[(i + (j - 1)) % 256] == 1)
                        num_neighbors = num_neighbors + 1;
                    
                    // Check top neighbor
                    if (temp_q[(i + (j - 16)) % 256] == 1)
                        num_neighbors = num_neighbors + 1;
                    
                    // Check top right neighbor
                    if (temp_q[(i + (j - 15)) % 256] == 1)
                        num_neighbors = num_neighbors + 1;
                    
                    // Check left neighbor
                    if (temp_q[(i + (j - 17)) % 256] == 1)
                        num_neighbors = num_neighbors + 1;
                    
                    // Check right neighbor
                    if (temp_q[(i + (j + 1)) % 256] == 1)
                        num_neighbors = num_neighbors + 1;
                    
                    // Check bottom left neighbor
                    if (temp_q[(i + (j + 15)) % 256] == 1)
                        num_neighbors = num_neighbors + 1;
                    
                    // Check bottom neighbor
                    if (temp_q[(i + (j + 16)) % 256] == 1)
                        num_neighbors = num_neighbors + 1;
                    
                    // Check bottom right neighbor
                    if (temp_q[(i + (j + 17)) % 256] == 1)
                        num_neighbors = num_neighbors + 1;
                    
                    // Update cell state based on number of neighbors
                    if (num_neighbors <= 1) begin
                        q[i + j] <= 0;
                    end else if (num_neighbors == 2) begin
                        q[i + j] <= temp_q[i + j];
                    end else if (num_neighbors == 3) begin
                        q[i + j] <= 1;
                    end else if (num_neighbors >= 4) begin
                        q[i + j] <= 0;
                    end
                end
            end
        end
    end

endmodule
