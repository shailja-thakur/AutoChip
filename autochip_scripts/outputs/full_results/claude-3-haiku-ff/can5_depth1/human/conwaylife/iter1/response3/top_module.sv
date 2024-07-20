module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

wire [255:0] next_state;

// Compute the next state
genvar i;
generate
    for (i = 0; i < 256; i = i + 1) begin
        wire [8:0] neighbors;
        // Compute the number of neighbors for each cell
        assign neighbors[0] = q[(i-16+256)%256];   // Top
        assign neighbors[1] = q[(i-1+256)%256];    // Left
        assign neighbors[2] = q[(i+1)%256];        // Right
        assign neighbors[3] = q[(i+16)%256];       // Bottom
        assign neighbors[4] = q[(i-17+256)%256];   // Top-left
        assign neighbors[5] = q[(i-15+256)%256];   // Top-right
        assign neighbors[6] = q[(i+15)%256];       // Bottom-right
        assign neighbors[7] = q[(i+17)%256];       // Bottom-left
        assign neighbors[8] = q[i];                // Self

        // Compute the next state based on the number of neighbors
        assign next_state[i] = (q[i] & (neighbors[0] + neighbors[1] + neighbors[2] + neighbors[3] + neighbors[4] + neighbors[5] + neighbors[6] + neighbors[7] == 2 || neighbors[0] + neighbors[1] + neighbors[2] + neighbors[3] + neighbors[4] + neighbors[5] + neighbors[6] + neighbors[7] == 3)) | 
                              (~q[i] & neighbors[0] + neighbors[1] + neighbors[2] + neighbors[3] + neighbors[4] + neighbors[5] + neighbors[6] + neighbors[7] == 3);
    end
endgenerate

always @(posedge clk) begin
    if (load)
        q <= data;
    else
        q <= next_state;
end

endmodule
