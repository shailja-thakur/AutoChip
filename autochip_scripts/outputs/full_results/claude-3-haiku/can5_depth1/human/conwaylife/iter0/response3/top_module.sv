module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_state;

always @(*) begin
    next_state = q;
    for (int i = 0; i < 256; i++) begin
        int neighbors = 0;
        if (i % 16 != 0)        neighbors += q[i-1]; // Left neighbor
        if (i % 16 != 15)       neighbors += q[i+1]; // Right neighbor
        if (i >= 16)            neighbors += q[i-16]; // Top neighbor
        if (i < 240)            neighbors += q[i+16]; // Bottom neighbor
        if (i >= 16 && i % 16 != 0)   neighbors += q[i-17]; // Top-left neighbor
        if (i >= 16 && i % 16 != 15)  neighbors += q[i-15]; // Top-right neighbor
        if (i < 240 && i % 16 != 0)   neighbors += q[i+15]; // Bottom-left neighbor
        if (i < 240 && i % 16 != 15)  neighbors += q[i+17]; // Bottom-right neighbor
        
        if (q[i] == 1) begin
            if (neighbors < 2 || neighbors > 3)
                next_state[i] = 0;
            else
                next_state[i] = 1;
        end else begin
            if (neighbors == 3)
                next_state[i] = 1;
            else
                next_state[i] = 0;
        end
    end
end

always @(posedge clk) begin
    if (load)
        q <= data;
    else
        q <= next_state;
end

endmodule
