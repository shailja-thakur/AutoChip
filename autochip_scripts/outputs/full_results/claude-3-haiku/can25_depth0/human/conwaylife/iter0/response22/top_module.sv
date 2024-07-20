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
        if (i > 0 && q[i-1]) neighbors++; // left
        if (i < 255 && q[i+1]) neighbors++; // right
        if (i >= 16 && q[i-16]) neighbors++; // up
        if (i < 240 && q[i+16]) neighbors++; // down
        if (i > 15 && q[i-17]) neighbors++; // up-left
        if (i < 255 && i >= 16 && q[i-15]) neighbors++; // up-right
        if (i >= 16 && i < 240 && q[i+15]) neighbors++; // down-left
        if (i > 0 && i < 240 && q[i+17]) neighbors++; // down-right
        
        if (q[i] && (neighbors == 2 || neighbors == 3)) begin
            next_q[i] = 1;
        end else if (!q[i] && neighbors == 3) begin
            next_q[i] = 1;
        end else begin
            next_q[i] = 0;
        end
    end
end

endmodule
