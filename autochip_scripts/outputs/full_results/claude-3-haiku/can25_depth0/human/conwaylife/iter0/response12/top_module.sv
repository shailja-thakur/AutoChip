module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_q;

always @(posedge clk) begin
    if (load)
        q <= data;
    else
        q <= next_q;
end

always @(*) begin
    next_q = q;
    for (int i = 0; i < 256; i++) begin
        int neighbors = 0;
        int row = i / 16;
        int col = i % 16;
        
        // Check the 8 neighboring cells
        if (row > 0) neighbors += q[i-16]; // North
        if (row < 15) neighbors += q[i+16]; // South
        if (col > 0) neighbors += q[i-1]; // West
        if (col < 15) neighbors += q[i+1]; // East
        if (row > 0 && col > 0) neighbors += q[i-17]; // North-West
        if (row > 0 && col < 15) neighbors += q[i-15]; // North-East
        if (row < 15 && col > 0) neighbors += q[i+15]; // South-West
        if (row < 15 && col < 15) neighbors += q[i+17]; // South-East
        
        // Update the cell state
        if (q[i] && (neighbors == 2 || neighbors == 3))
            next_q[i] = 1;
        else if (!q[i] && neighbors == 3)
            next_q[i] = 1;
        else
            next_q[i] = 0;
    end
end

endmodule
