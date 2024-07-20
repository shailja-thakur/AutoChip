module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_state;

always @(*) begin
    // Compute the next state from the current state
    for (int i = 0; i < 256; i++) begin
        int neighbors = 0;
        // Compute the number of alive neighbors for cell i
        for (int j = -1; j <= 1; j++) begin
            for (int k = -1; k <= 1; k++) begin
                int row = (i / 16 + j + 16) % 16;
                int col = (i % 16 + k + 16) % 16;
                int neighbor_index = row * 16 + col;
                if ((neighbor_index != i) && q[neighbor_index]) begin
                    neighbors++;
                end
            end
        end
        // Update the next state based on the number of neighbors
        if (q[i]) begin
            if (neighbors < 2 || neighbors > 3) begin
                next_state[i] = 0;
            end else begin
                next_state[i] = 1;
            end
        end else begin
            if (neighbors == 3) begin
                next_state[i] = 1;
            end else begin
                next_state[i] = 0;
            end
        end
    end
end

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        q <= next_state;
    end
end

endmodule
