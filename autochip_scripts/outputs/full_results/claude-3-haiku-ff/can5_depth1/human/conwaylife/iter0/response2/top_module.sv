module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_state;

always @(posedge clk) begin
    if (load)
        q <= data;
    else
        q <= next_state;
end

always @(*) begin
    next_state = q;
    for (int i = 0; i < 256; i++) begin
        int neighbors = 0;
        
        // Calculate the number of neighbors for the current cell
        if (i % 16 != 0)       neighbors += q[i-1];    // Left
        if (i % 16 != 15)      neighbors += q[i+1];    // Right
        if (i >= 16)           neighbors += q[i-16];   // Up
        if (i < 240)           neighbors += q[i+16];   // Down
        if (i % 16 != 0 && i >= 16)   neighbors += q[i-17];  // Up-Left
        if (i % 16 != 15 && i >= 16)  neighbors += q[i-15];  // Up-Right
        if (i % 16 != 0 && i < 240)   neighbors += q[i+15];  // Down-Left
        if (i % 16 != 15 && i < 240)  neighbors += q[i+17];  // Down-Right
        
        // Update the next state based on the number of neighbors
        if (q[i] == 1'b0 && neighbors == 3)
            next_state[i] = 1'b1;
        else if (q[i] == 1'b1 && (neighbors < 2 || neighbors > 3))
            next_state[i] = 1'b0;
        else
            next_state[i] = q[i];
    end
end

endmodule
