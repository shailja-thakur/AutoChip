module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_q;

always @(*) begin
    // Compute the next state of the game based on the current state
    for (int i = 0; i < 256; i++) begin
        int neighbors = 0;
        // Compute the number of neighbors for the current cell
        if (i % 16 != 0)         neighbors += q[i - 1]; // left neighbor
        if (i % 16 != 15)        neighbors += q[i + 1]; // right neighbor
        if (i >= 16)             neighbors += q[i - 16]; // top neighbor
        if (i < 240)             neighbors += q[i + 16]; // bottom neighbor
        if (i >= 16 && i % 16 != 0)   neighbors += q[i - 17]; // top left neighbor
        if (i >= 16 && i % 16 != 15)  neighbors += q[i - 15]; // top right neighbor
        if (i < 240 && i % 16 != 0)   neighbors += q[i + 15]; // bottom left neighbor
        if (i < 240 && i % 16 != 15)  neighbors += q[i + 17]; // bottom right neighbor
        
        // Update the next state of the current cell based on the number of neighbors
        if (q[i] == 0 && neighbors == 3)
            next_q[i] = 1;
        else if (q[i] == 1 && (neighbors < 2 || neighbors > 3))
            next_q[i] = 0;
        else
            next_q[i] = q[i];
    end
end

always @(posedge clk) begin
    if (load)
        q <= data;
    else
        q <= next_q;
end

endmodule
