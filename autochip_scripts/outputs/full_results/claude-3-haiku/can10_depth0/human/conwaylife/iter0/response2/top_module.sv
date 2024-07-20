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
    next_state = q;
    for (int i = 0; i < 256; i++) begin
        int neighbors = 0;
        
        // Calculate the number of neighbors for the current cell
        if (i % 16 > 0)           neighbors += q[i-1];   // Left
        if (i % 16 < 15)          neighbors += q[i+1];   // Right
        if (i / 16 > 0)           neighbors += q[i-16];  // Up
        if (i / 16 < 15)          neighbors += q[i+16];  // Down
        if (i % 16 > 0 && i / 16 > 0)        neighbors += q[i-17]; // Up-Left
        if (i % 16 < 15 && i / 16 > 0)       neighbors += q[i-15]; // Up-Right
        if (i % 16 > 0 && i / 16 < 15)       neighbors += q[i+15]; // Down-Left
        if (i % 16 < 15 && i / 16 < 15)      neighbors += q[i+17]; // Down-Right
        
        // Update the next state based on the number of neighbors
        if (q[i] == 1'b1) begin
            if (neighbors < 2 || neighbors > 3) begin
                next_state[i] = 1'b0; // Cell dies
            end
            else begin
                next_state[i] = 1'b1; // Cell survives
            end
        end
        else begin
            if (neighbors == 3) begin
                next_state[i] = 1'b1; // Cell is born
            end
            else begin
                next_state[i] = 1'b0; // Cell remains dead
            end
        end
    end
end

endmodule
