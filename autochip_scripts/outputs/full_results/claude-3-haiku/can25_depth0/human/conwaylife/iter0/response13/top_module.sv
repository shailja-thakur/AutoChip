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
        int alive_neighbors = 0;
        
        // Calculate the number of alive neighbors for cell i
        if (i % 16 > 0)              alive_neighbors += q[i-1];
        if (i % 16 < 15)             alive_neighbors += q[i+1];
        if (i >= 16)                 alive_neighbors += q[i-16];
        if (i < 240)                 alive_neighbors += q[i+16];
        if (i % 16 > 0 && i >= 16)    alive_neighbors += q[i-17];
        if (i % 16 < 15 && i >= 16)   alive_neighbors += q[i-15];
        if (i % 16 > 0 && i < 240)    alive_neighbors += q[i+15];
        if (i % 16 < 15 && i < 240)   alive_neighbors += q[i+17];
        
        // Update the next state of cell i
        if (q[i] == 1'b1) begin
            if (alive_neighbors < 2 || alive_neighbors > 3)
                next_q[i] = 1'b0;
            else
                next_q[i] = 1'b1;
        end
        else begin
            if (alive_neighbors == 3)
                next_q[i] = 1'b1;
            else
                next_q[i] = 1'b0;
        end
    end
end

endmodule
