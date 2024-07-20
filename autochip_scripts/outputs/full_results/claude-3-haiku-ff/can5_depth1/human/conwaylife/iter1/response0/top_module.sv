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

always @(*) begin
    for (int i = 0; i < 256; i++) begin
        int neighbors = 0;
        
        // Count the number of neighbors
        neighbors += q[(i-16+256)%256]; // Top
        neighbors += q[(i-1+256)%256]; // Left
        neighbors += q[(i+1)%256]; // Right
        neighbors += q[(i+16)%256]; // Bottom
        neighbors += q[(i-17+256)%256]; // Top-left
        neighbors += q[(i-15+256)%256]; // Top-right
        neighbors += q[(i+15)%256]; // Bottom-right
        neighbors += q[(i+17)%256]; // Bottom-left
        
        // Update the next state based on the number of neighbors
        next_state[i] = (q[i] & (neighbors == 2 || neighbors == 3)) | (~q[i] & neighbors == 3);
    end
end

endmodule
