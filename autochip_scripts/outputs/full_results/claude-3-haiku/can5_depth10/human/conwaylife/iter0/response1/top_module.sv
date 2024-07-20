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

always @(*) begin
    next_q = q;
    for (int i = 0; i < 256; i++) begin
        int neighbors = 0;
        if (i > 0 && q[i-1]) neighbors++; // Left
        if (i < 255 && q[i+1]) neighbors++; // Right
        if (i >= 16 && q[i-16]) neighbors++; // Top
        if (i < 240 && q[i+16]) neighbors++; // Bottom
        if (i > 15 && q[i-17]) neighbors++; // Top Left
        if (i < 255 && i >= 16 && q[i-15]) neighbors++; // Top Right
        if (i >= 16 && i < 240 && q[i+15]) neighbors++; // Bottom Left
        if (i < 240 && i >= 0 && q[i+17]) neighbors++; // Bottom Right

        case (neighbors)
            2: next_q[i] = q[i]; // Cell state does not change
            3: next_q[i] = 1;   // Cell becomes 1
            default: next_q[i] = 0; // Cell becomes 0
        endcase
    end
end

endmodule
