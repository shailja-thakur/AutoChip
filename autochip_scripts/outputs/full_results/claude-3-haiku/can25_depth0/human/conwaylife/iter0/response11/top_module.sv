module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_state;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        q <= next_state;
    end
end

always @* begin
    next_state = q;
    for (int i = 0; i < 256; i++) begin
        int neighbors = 0;
        // Calculate the number of neighbors for each cell
        if (i > 0 && q[i-1]) neighbors++; // Left neighbor
        if (i < 255 && q[i+1]) neighbors++; // Right neighbor
        if (i >= 16 && q[i-16]) neighbors++; // Top neighbor
        if (i < 240 && q[i+16]) neighbors++; // Bottom neighbor
        if (i >= 16 && i > 0 && q[i-17]) neighbors++; // Top-left neighbor
        if (i >= 16 && i < 255 && q[i-15]) neighbors++; // Top-right neighbor
        if (i < 240 && i < 255 && q[i+17]) neighbors++; // Bottom-right neighbor
        if (i < 240 && i > 0 && q[i+15]) neighbors++; // Bottom-left neighbor

        // Apply the game of life rules
        if (q[i] && (neighbors == 2 || neighbors == 3)) begin
            next_state[i] = 1;
        end
        else if (!q[i] && neighbors == 3) begin
            next_state[i] = 1;
        end
        else begin
            next_state[i] = 0;
        end
    end
end

endmodule
