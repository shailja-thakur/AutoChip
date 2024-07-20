module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_state;

// Compute the next state
always @(*) begin
    for (int i = 0; i < 256; i = i + 1) begin
        int neighbors = 0;
        
        // Compute the number of neighbors for each cell
        if (q[(i-16+256)%256]) neighbors++; // Top
        if (q[(i-1+256)%256]) neighbors++; // Left
        if (q[(i+1)%256]) neighbors++; // Right
        if (q[(i+16)%256]) neighbors++; // Bottom
        if (q[(i-17+256)%256]) neighbors++; // Top-left
        if (q[(i-15+256)%256]) neighbors++; // Top-right
        if (q[(i+15)%256]) neighbors++; // Bottom-right
        if (q[(i+17)%256]) neighbors++; // Bottom-left
        if (q[i]) neighbors++; // Self
        
        // Compute the next state based on the number of neighbors
        next_state[i] = (q[i] & (neighbors == 2 || neighbors == 3)) | (~q[i] & neighbors == 3);
    end
end

always @(posedge clk) begin
    if (load)
        q <= data;
    else
        q <= next_state;
end

endmodule
