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
    next_q = 0;
    
    // Compute the next state of the game
    for (int i = 0; i < 16; i++) begin
        for (int j = 0; j < 16; j++) begin
            int idx = i * 16 + j;
            int neighbors = 0;
            
            // Check the 8 neighboring cells
            if (q[idx - 1] && j != 0) neighbors++;
            if (q[idx + 1] && j != 15) neighbors++;
            if (q[idx - 16] && i != 0) neighbors++;
            if (q[idx + 16] && i != 15) neighbors++;
            if (q[idx - 17] && i != 0 && j != 0) neighbors++;
            if (q[idx - 15] && i != 0 && j != 15) neighbors++;
            if (q[idx + 15] && i != 15 && j != 0) neighbors++;
            if (q[idx + 17] && i != 15 && j != 15) neighbors++;
            
            // Apply the game rules
            if (q[idx] && (neighbors == 2 || neighbors == 3)) begin
                next_q[idx] = 1;
            end
            else if (!q[idx] && neighbors == 3) begin
                next_q[idx] = 1;
            end
            else begin
                next_q[idx] = 0;
            end
        end
    end
end

endmodule
