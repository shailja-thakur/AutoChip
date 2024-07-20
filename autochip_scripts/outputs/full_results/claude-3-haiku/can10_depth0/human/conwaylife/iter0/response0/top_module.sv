module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_state;

always @(*) begin
    next_state = q;
    for (integer i = 0; i < 16; i++) begin
        for (integer j = 0; j < 16; j++) begin
            integer index = i * 16 + j;
            integer live_neighbors = 0;
            // Calculate number of live neighbors
            if (i > 0)
                live_neighbors += q[(index - 16) % 256];
            if (i < 15)
                live_neighbors += q[(index + 16) % 256];
            if (j > 0)
                live_neighbors += q[(index - 1) % 256];
            if (j < 15)
                live_neighbors += q[(index + 1) % 256];
            if (i > 0 && j > 0)
                live_neighbors += q[(index - 17) % 256];
            if (i > 0 && j < 15)
                live_neighbors += q[(index - 15) % 256];
            if (i < 15 && j > 0)
                live_neighbors += q[(index + 15) % 256];
            if (i < 15 && j < 15)
                live_neighbors += q[(index + 17) % 256];
            // Update the next state based on the number of live neighbors
            if (q[index] == 1'b1) begin // Cell is alive
                if (live_neighbors < 2 || live_neighbors > 3)
                    next_state[index] = 1'b0; // Cell dies
                else
                    next_state[index] = 1'b1; // Cell stays alive
            end else begin // Cell is dead
                if (live_neighbors == 3)
                    next_state[index] = 1'b1; // Cell becomes alive
                else
                    next_state[index] = 1'b0; // Cell stays dead
            end
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
