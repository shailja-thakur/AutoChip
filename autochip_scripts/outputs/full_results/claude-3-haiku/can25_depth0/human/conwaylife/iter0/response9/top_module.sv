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
    end
    else begin
        q <= next_q;
    end
end

always @* begin
    next_q = q;
    for (int i = 0; i < 256; i++) begin
        int neighbors = 0;
        if (i > 0) neighbors += q[i-1]; // Left neighbor
        if (i < 255) neighbors += q[i+1]; // Right neighbor
        if (i >= 16) neighbors += q[i-16]; // Top neighbor
        if (i < 240) neighbors += q[i+16]; // Bottom neighbor
        if (i > 15) neighbors += q[i-17]; // Top left neighbor
        if (i < 239) neighbors += q[i+17]; // Bottom right neighbor
        if (i >= 16 && i < 255) neighbors += q[i-15]; // Top right neighbor
        if (i >= 0 && i < 240) neighbors += q[i+15]; // Bottom left neighbor
        case (neighbors)
            2: next_q[i] = q[i]; // Cell state does not change
            3: next_q[i] = 1; // Cell becomes alive
            default: next_q[i] = 0; // Cell becomes dead
        endcase
    end
end

endmodule
