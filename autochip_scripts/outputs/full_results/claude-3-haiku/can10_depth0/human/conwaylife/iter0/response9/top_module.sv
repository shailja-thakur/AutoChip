module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_q;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        q <= next_q;
    end
end

always @(*) begin
    next_q = q;
    for (int i = 0; i < 256; i++) begin
        int neighbors = 0;
        int x = i % 16;
        int y = i / 16;
        
        // Count number of neighbors
        if (q[(((y-1)+16)%16)*16 + ((x-1)+16)%16]) neighbors++; // Top-left
        if (q[(((y-1)+16)%16)*16 + x]) neighbors++; // Top
        if (q[(((y-1)+16)%16)*16 + ((x+1)%16)]) neighbors++; // Top-right
        if (q[y*16 + ((x-1)+16)%16]) neighbors++; // Left
        if (q[y*16 + ((x+1)%16)]) neighbors++; // Right
        if (q[(((y+1)%16)*16) + ((x-1)+16)%16]) neighbors++; // Bottom-left
        if (q[(((y+1)%16)*16) + x]) neighbors++; // Bottom
        if (q[(((y+1)%16)*16) + ((x+1)%16)]) neighbors++; // Bottom-right
        
        // Update next state based on number of neighbors
        if (q[i]) begin
            if (neighbors == 2 || neighbors == 3) begin
                next_q[i] = 1;
            end else begin
                next_q[i] = 0;
            end
        end else begin
            if (neighbors == 3) begin
                next_q[i] = 1;
            end else begin
                next_q[i] = 0;
            end
        end
    end
end

endmodule
