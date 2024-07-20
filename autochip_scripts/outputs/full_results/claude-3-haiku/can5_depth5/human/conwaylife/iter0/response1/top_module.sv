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
        
        // Calculate number of alive neighbors for cell i
        if (i % 16 != 0) begin             // Left neighbor
            alive_neighbors += q[i-1];
        end
        else begin                         // Wrap-around left neighbor
            alive_neighbors += q[i-1+16];
        end
        
        if (i % 16 != 15) begin            // Right neighbor
            alive_neighbors += q[i+1];
        end
        else begin                         // Wrap-around right neighbor
            alive_neighbors += q[i+1-16];
        end
        
        if (i >= 16) begin                 // Top neighbor
            alive_neighbors += q[i-16];
        end
        else begin                         // Wrap-around top neighbor
            alive_neighbors += q[i+240];
        end
        
        if (i < 240) begin                 // Bottom neighbor
            alive_neighbors += q[i+16];
        end
        else begin                         // Wrap-around bottom neighbor
            alive_neighbors += q[i-240];
        end
        
        // Apply game of life rules
        if (q[i] == 1'b1) begin            // Cell is alive
            if (alive_neighbors < 2 || alive_neighbors > 3) begin
                next_q[i] = 1'b0;          // Cell dies
            end
            else begin
                next_q[i] = 1'b1;          // Cell lives
            end
        end
        else begin                         // Cell is dead
            if (alive_neighbors == 3) begin
                next_q[i] = 1'b1;          // Cell is born
            end
            else begin
                next_q[i] = 1'b0;          // Cell stays dead
            end
        end
    end
end

endmodule
