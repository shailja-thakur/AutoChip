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
            // Compute next state
            for (integer i = 0; i < 256; i = i + 1) begin
                reg [7:0] neighbors;
                if (i % 16 == 0) begin
                    // Left edge
                    neighbors = q[(i + 15) % 256] +
                                q[(i + 16) % 256] +
                                q[(i + 1) % 256] +
                                q[(i + 15) % 256 + 16] +
                                q[i + 1] +
                                q[i + 16] +
                                q[(i + 15) % 256 + 31] +
                                q[(i + 31) % 256];
                end else if (i % 16 == 15) begin
                    // Right edge
                    neighbors = q[(i - 1) % 256] +
                                q[(i + 15) % 256] +
                                q[(i - 15) % 256] +
                                q[(i - 1) % 256 + 15] +
                                q[(i + 15) % 256 + 1] +
                                q[(i - 1) % 256 + 1] +
                                q[i - 16] +
                                q[i];
                end else begin
                    // Middle cells
                    neighbors = q[(i - 1) % 256] +
                                q[(i + 1) % 256] +
                                q[(i - 16) % 256] +
                                q[(i + 16) % 256] +
                                q[(i - 15) % 256] +
                                q[(i - 16) % 256 + 1] +
                                q[(i + 16) % 256 + 1] +
                                q[(i + 15) % 256 + 1];
                end

                // Update cell based on neighbors
                if (neighbors <= 1) begin
                    next_q[i] = 0;
                end else if (neighbors == 2) begin
                    next_q[i] = q[i];
                end else if (neighbors == 3) begin
                    next_q[i] = 1;
                end else begin
                    next_q[i] = 0;
                end
            end

            // Update current state
            q <= next_q;
        end
    end
endmodule
