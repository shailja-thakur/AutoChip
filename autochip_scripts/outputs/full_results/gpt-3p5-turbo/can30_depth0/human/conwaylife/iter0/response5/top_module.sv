module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] next_q; // Store next state of the game

    // Logic for updating the game state
    always @ (posedge clk) begin
        if (load) begin
            // Load initial state
            q <= data;
        end else begin
            // Update game state
            for (int i = 0; i < 16; i = i + 1) begin
                for (int j = 0; j < 16; j = j + 1) begin
                    int num_neighbors = 0;

                    // Check if current cell is alive
                    if (q[i * 16 + j] == 1) begin
                        // Check left neighbor
                        if (q[i * 16 + (j - 1)] == 1)
                            num_neighbors = num_neighbors + 1;

                        // Check right neighbor
                        if (q[i * 16 + (j + 1)] == 1)
                            num_neighbors = num_neighbors + 1;

                        // Check above neighbor
                        if (q[((i - 1) % 16) * 16 + j] == 1)
                            num_neighbors = num_neighbors + 1;

                        // Check below neighbor
                        if (q[((i + 1) % 16) * 16 + j] == 1)
                            num_neighbors = num_neighbors + 1;

                        // Check top-left neighbor
                        if (q[((i - 1) % 16) * 16 + (j - 1)] == 1)
                            num_neighbors = num_neighbors + 1;

                        // Check top-right neighbor
                        if (q[((i - 1) % 16) * 16 + (j + 1)] == 1)
                            num_neighbors = num_neighbors + 1;

                        // Check bottom-left neighbor
                        if (q[((i + 1) % 16) * 16 + (j - 1)] == 1)
                            num_neighbors = num_neighbors + 1;

                        // Check bottom-right neighbor
                        if (q[((i + 1) % 16) * 16 + (j + 1)] == 1)
                            num_neighbors = num_neighbors + 1;

                        // Apply rules for updating cell state
                        if (num_neighbors < 2 || num_neighbors >= 4)
                            next_q[i * 16 + j] = 0;
                        else
                            next_q[i * 16 + j] = 1;
                    end else begin
                        // Check left neighbor
                        if (q[i * 16 + (j - 1)] == 1)
                            num_neighbors = num_neighbors + 1;

                        // Check right neighbor
                        if (q[i * 16 + (j + 1)] == 1)
                            num_neighbors = num_neighbors + 1;

                        // Check above neighbor
                        if (q[((i - 1) % 16) * 16 + j] == 1)
                            num_neighbors = num_neighbors + 1;

                        // Check below neighbor
                        if (q[((i + 1) % 16) * 16 + j] == 1)
                            num_neighbors = num_neighbors + 1;

                        // Check top-left neighbor
                        if (q[((i - 1) % 16) * 16 + (j - 1)] == 1)
                            num_neighbors = num_neighbors + 1;

                        // Check top-right neighbor
                        if (q[((i - 1) % 16) * 16 + (j + 1)] == 1)
                            num_neighbors = num_neighbors + 1;

                        // Check bottom-left neighbor
                        if (q[((i + 1) % 16) * 16 + (j - 1)] == 1)
                            num_neighbors = num_neighbors + 1;

                        // Check bottom-right neighbor
                        if (q[((i + 1) % 16) * 16 + (j + 1)] == 1)
                            num_neighbors = num_neighbors + 1;

                        // Apply rules for updating cell state
                        if (num_neighbors == 3)
                            next_q[i * 16 + j] = 1;
                        else
                            next_q[i * 16 + j] = 0;
                    end
                end
            end

            // Update game state
            q <= next_q;
        end
    end

endmodule
